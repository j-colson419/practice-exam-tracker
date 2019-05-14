({
    doInit : function(component, event, helper) {
        var examType = component.get('v.examType');
        var action1 = component.get('c.getExamTypeFromAttemptId');
        action1.setParams({
            "attemptId" :  component.get('v.recordId')
        });
        action1.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS' && component.isValid){
                var action = component.get('c.getAttemptScoreTemplatesForExamType');
                action.setParams({
                    "examType" : response.getReturnValue(),
                    "attemptId" : component.get('v.recordId')
                });
                action.setCallback(this, function(response){
                    var state = response.getState();
                    if(state == 'SUCCESS' && component.isValid){
                        component.set('v.scoresToInsert', response.getReturnValue());
                        
                    } else {
                        console.log('Something went wrong while trying to get exam categories from the server.');
                    }
                });
                $A.enqueueAction(action);
            } else {
                console.log('Something went wrong while trying to get the exam type from the server.');
            }
        });
        $A.enqueueAction(action1);
        
    },
    
    submitScores : function(component, event, helper){
        var scores = component.get("v.scoresToInsert");
        var action = component.get("c.insertAttemptScores");
        action.setParams({
            "scoresToInsert" : scores
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS' && component.isValid){
                console.log('SUCCESS!!!!!!');
            } else {
                console.log('Something went wrong while trying to create new Attempt Score records.');
            }
        });
        $A.enqueueAction(action);
    }
})