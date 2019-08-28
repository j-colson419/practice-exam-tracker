({
	handleMenuSelect : function(component, event, helper) {
		//This method should check the value of the selected menu item,
		//then either close the form (or redirect back to the batch record page), 
		//or clear the form entirely.
		var value = event.getParam("value");
        if(value == 'ClearForm'){
            component.set('v.newWeek', { 'sobjectType': 'Week__c',
                                         'Week_Number__c' : '',
                                         'Batch__c' : component.get('v.recordId')
                                       }
                         );
            var emptyList = [];
            component.set('v.selectedTopics', emptyList);
            component.set('v.selectedSubtopics', emptyList);
             var evt = $A.get('e.force:refreshView');
            evt.fire();
        } else if(value == 'Cancel'){
            alert('Theres currently a bug preventing this functionality. Sorry');
            /*var navService = component.find('navService');
            var pageReference = {
                'type': 'standard__recordPage',
                'attributes': {
                    'objectApiName': 'Batch__c',
                    'actionName': 'view',
                    'recordId': component.get('v.recordId')
                }
            };
            event.preventDefault();
            navService.navigate(pageReference);*/
        }
		
	},
    
    onInit : function(component, event, helper){
        component.set('v.newWeek.Batch__c', component.get('v.recordId'));
        var getTopics = component.get('c.getAvailableTopics');
        var getSubtopics = component.get('c.getAvailableSubtopics');
        getTopics.setCallback(this, function(response){
           var state = response.getState();
            if(state == 'SUCCESS' && component.isValid()){
                var topics = [];
                for(var obj in response.getReturnValue()){
                    topics.push({'label' : response.getReturnValue()[obj],
                                 'value' : obj});
                }
                component.set('v.topicOptions', topics);
            } else {
                console.error('Something went wrong while trying to get available question topics on initialization.');
            }
        });
        getSubtopics.setCallback(this, function(response){
           var state = response.getState();
            if(state == 'SUCCESS' && component.isValid()){
                var subtopics = [];
                for(var obj in response.getReturnValue()){
                    subtopics.push({'label' : response.getReturnValue()[obj],
                                 'value' : obj});
                }
                component.set('v.subtopicOptions', subtopics);
            } else {
                console.error('Something went wrong while trying to get available question subtopics on initialization.');
            }
        });
        $A.enqueueAction(getTopics);
        $A.enqueueAction(getSubtopics);
    },
    
    updateSelectedSubtopics : function(component, event, helper){
        component.set('v.selectedSubtopics', event.getParam("value"));
        console.log(component.get('v.selectedSubtopics'));
    },
    
    updateSelectedTopics : function(component, event, helper){
        component.set('v.selectedTopics', event.getParam("value"));
    },
    
    createNewWeekAndRelatedRecords : function(component, event, helper){
        var action = component.get('c.createWeekAndTopicsCoveredForBatch');
        action.setParams({
            "newWeek" : component.get('v.newWeek'),
            "topicsCovered" : component.get('v.selectedTopics'),
            "subtopicsCovered" : component.get('v.selectedSubtopics')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS'){
                console.log('The state was success, so hopefully it worked!');
            } else {
                console.log('Something went wrong while trying to insert the new records.');
            }
        });
        $A.enqueueAction(action);
    }
})