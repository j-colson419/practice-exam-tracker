({
	handleMenuSelect : function(component, event, helper) {
		//This method should check the value of the selected menu item,
		//then either close the form (or redirect back to previous page), 
		//or clear the form entirely.
		
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
        
    },
    
    updateSelectedTopics : function(component, event, helper){
        
    }
})