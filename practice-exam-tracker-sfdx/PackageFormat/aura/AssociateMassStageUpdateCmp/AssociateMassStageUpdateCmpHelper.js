({
	getAssociateData : function(component) {
		var action = component.get('c.getAssociateDataForTable');
        action.setCallback(this, function(resp){
            var state = resp.getState();
            if(state === 'SUCCESS' && component.isValid){
                component.set('v.associateData', resp.getReturnValue());
            } else {
                console.log('Error while getting associate data from server. \n Response State: ' + state + '.');
            }
        });
        $A.enqueueAction(action);
	},
    
    getOptions : function(component) {
        var action = component.get('c.getMasterStagePicklistValues');
        action.setCallback(this, function(resp){
            var state = resp.getState();
            if(state === 'SUCCESS' && component.isValid){
                component.set('v.stageValueOptions', resp.getReturnValue());
            } else {
                console.log('Error while getting master stage values from server. \n Response State: ' + state + '.');
            }
        });
        $A.enqueueAction(action);
    }
})