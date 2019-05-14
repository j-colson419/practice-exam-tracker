({
    doInit : function(component, event, helper) {
        var action = component.get('c.getRelatedScores');
        action.setParams({
            "attemptId" : component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS' && component.isValid){
                component.set('v.scores', response.getReturnValue());
                component.set('v.readOnly', (response.getReturnValue()[0].Id != null && response.getReturnValue()[0].Id != undefined));
                console.log(response.getReturnValue()[0]);
                console.log(component.get('v.readOnly'));
            } else {
                console.log('Something went wrong while trying to get related scores from the server.');
            }
        });
        $A.enqueueAction(action);
    },
    
    handleAttemptScoreInsertEvent : function(component, event, helper){
        var resultString = event.getParam('result');
        if(resultString == 'Success'){
            component.find('notifLib').showToast({
                "title" : "Success!",
                "message" : "Scores for this Exam Attempt were successfully inserted.",
                "variant" : "success",
                "mode" : "dismissible"
            });
        } else if(resultString == 'Error'){
            component.find('notifLib').showToast({
                "title" : "Error!",
                "message" : "An error occurred while trying to insert scores for this exam attempt.",
                "variant" : "error",
                "mode" : "dismissible"
            });
        }
        $A.get('e.force:refreshView').fire();
    }
})