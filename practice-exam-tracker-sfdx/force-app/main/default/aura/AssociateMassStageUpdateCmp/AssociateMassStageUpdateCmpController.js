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
        
    }
})