({
	handleSuccess : function(component, event, helper) {
		component.set('v.attemptId', event.getParam("id"));
        
	},
    
    onInit : function(component, event, helper){
        var action = component.get('c.getAttemptRecordTypes');
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid){
                var obj = [];
                for(var i = 0; i < response.getReturnValue().length; i++){
                    obj.push({label:response.getReturnValue()[i].Name, value:response.getReturnValue()[i].Id});
                }
                //console.log(obj);
                component.set('v.rtOptions', obj);
            } else {
                console.log('Something went wrong while trying to get record types.');
            }
        });
        $A.enqueueAction(action);
    }
})