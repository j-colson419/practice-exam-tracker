({
    submitScores : function(component, event, helper){
        var scores = component.get("v.scores");
        var action = component.get("c.upsertAttemptScores");
        action.setParams({
            "scores" : scores
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var resultString;
            if(state == 'SUCCESS' && component.isValid){
                resultString = 'Success';
            } else {
                console.log('Something went wrong while trying to create new Attempt Score records.');
            	resultString = 'Error';
            }
            var cmpEvt = component.getEvent("attemptScoreInsertEvent");
                cmpEvt.setParams({
                    "result" : resultString    
                });
                cmpEvt.fire();
        });
        $A.enqueueAction(action);
    }
})