public class AssociateMassStageUpdateController {

    @AuraEnabled
    public static List<Contact> getAssociateDataForTable(){
        List<Contact> associateList = [SELECT Id, FirstName, LastName, Master_Stage__c, 
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
    
    @AuraEnabled
    public static Integer updateMasterStageValue(List<Contact> associates, String newValue){
        for(Contact c : associates){
            c.Master_Stage__c = newValue;
        }
        try {
            update associates;
            return associates.size();
        } catch (Exception e){
            System.debug('An unexpected error occurred while trying to update associates master stage value.');
            throw new AuraHandledException('An unexpected error occurred while trying to update associates master stage value.');
        }
    }
    
}