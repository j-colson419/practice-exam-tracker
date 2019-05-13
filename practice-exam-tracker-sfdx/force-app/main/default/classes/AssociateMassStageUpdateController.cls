public class AssociateMassStageUpdateController {

    @AuraEnabled
    public static List<Contact> getAssociateDataForTable(){
        List<Contact> associateList = [SELECT Id, firstName, lastName, Master_Stage__c, 
                                       Admin_Certified__c, PD1_Certified__c
                                       FROM Contact];
        return associateList;
    }
    
    
    @AuraEnabled
    public static List<String> getMasterStagePicklistValues(){
        List<Schema.PicklistEntry> masterStageValues = Schema.SobjectType.Contact.fields.Master_Stage__c.getPicklistValues();
        List<String> masterStageOptionLabels = new List<String>();
        for(Schema.PicklistEntry pe : masterStageValues){
            masterStageOptionLabels.add(pe.getLabel());
        }
        return masterStageOptionLabels;
    }
    
}