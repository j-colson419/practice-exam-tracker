({
	init : function(component, event, helper) {
		/* set columns */
        component.set('v.columns', [
            {label: 'Record Id', fieldName: 'Id', type: 'text'},
            {label: 'First Name', fieldName: 'FirstName', type: 'text'},
            {label: 'Last Name', fieldName: 'LastName', type: 'text'},
            {label: 'Master Stage', fieldName: 'Master_Stage__c', type: 'text'},
            {label: 'Admin Certified', fieldName: 'Admin_Certified__c', type: 'boolean'},
            {label: 'Developer Certified', fieldName: 'PD1_Certified__c', type: 'boolean'}
        ]);
        
        /* get data */
        helper.getAssociateData(component);
        
        /* get master stage options */
        helper.getOptions(component);
        
	},
    
    updateSelected : function(component, event, helper) {
        var selectedRows = event.getParam('selectedRows');
        component.set('v.selectedRowsList', event.getParam('selectedRows'));
    },
    
    updateSelectedRecords : function(component, event, helper){
        var selectedRowsList = component.get('v.selectedRowsList');
        var newMasterStageValue = component.get('v.selectedStageValue');
        var action = component.get('c.updateMasterStageValue');
        action.setParams({
            "associates" : selectedRowsList,
            "newValue" : newMasterStageValue
        });
        action.setCallback(this, function(resp){
            var state = resp.getState();
            if(state === 'SUCCESS' && component.isValid){
                component.set('v.successMessage', resp.getReturnValue() + ' Associates were updated to have a Master Stage value of ' + newMasterStageValue);
                helper.getAssociateData(component);
            } else {
                console.log('Error while updating Associate records in database. \n Response State: ' + state + '.');
            }
        });
        $A.enqueueAction(action);
    }
})