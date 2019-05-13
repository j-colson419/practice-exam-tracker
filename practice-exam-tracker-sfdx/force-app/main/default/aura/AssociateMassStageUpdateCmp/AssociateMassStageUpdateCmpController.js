({
	init : function(component, event, helper) {
		/* set columns */
        component.set('v.columns', [
            {label: 'Record Id', fieldName: 'Id', type: 'text'},
            {label: 'First Name', fieldName: 'firstName', type: 'text'},
            {label: 'Last Name', fieldName: 'lastName', type: 'text'},
            {label: 'Master Stage', fieldName: 'Master_Stage__c', type: 'text'},
            {label: 'Admin Certified', fieldName: 'Admin_Certified__c', type: 'boolean'},
            {label: 'Developer Certified', fieldName: 'PD1_Certified__c', type: 'boolean'}
        ]);
        
        /* get data */
        helper.getAssociateData(component);
        
        /* get master stage options */
        helper.getOptions(component);
        
	},
    
    updateSelectedRecords : function(component, event, helper){
        var selectedRows = component.get('v.selectedRows');
        var newMasterStageValue = component.get('v.selectedStageValue');
        var action = component.get('c.updateMasterStageValue');
        action.setParams({
            "associates" : selectedRows,
            "newValue" : newMasterStageValue
        });
        action.setCallback(this, function(resp){
            var state = resp.getState();
            if(state === 'SUCCESS' && component.isValid){
                component.set('v.successMessage', resp.getReturnValue() + ' Associates were updated to have a Master Stage value of ' + newMasterStageValue);
            } else {
                console.log('Error while updating Associate records in database. \n Response State: ' + state + '.');
            }
        });
        $A.enqueueAction(action);
    }
})