@isTest
public class TestDataFactory {

    public static List<Contact> createNAssociates(Integer n){
        List<Contact> associateList = new List<Contact>();
        for(Integer i = 0; i < n; i++){
            associateList.add(new Contact(LastName = 'Test ' + i));
        }
        return associateList;
    }
    
    public static List<Batch__c> createNBatches(Integer n){
        List<Batch__c> batchList = new List<Batch__c>();
        for(Integer i = 0; i < n; i++){
            batchList.add(new Batch__c(Name = 'Test' + i + '-Salesforce', Start_Date__c = Date.newInstance(2019, Math.mod(i, 12)+1, Math.mod(i, 29)+1), Length__c = 10));
        }
        return batchList;
    }
    
    public static List<Batch__c> createNBatches(Integer n, Date startDate){
        List<Batch__c> batchList = new List<Batch__c>();
        for(Integer i = 0; i < n; i++){
            batchList.add(new Batch__c(Name = 'Test' + i + '-Salesforce', Start_Date__c = startDate, Length__c = 10));
        }
        return batchList;
    }
    
    public static List<Batch_Assignment__c> createBatchAssignments(List<Contact> associates, Batch__c batch){
        List<Batch_Assignment__c> assignmentsList = new List<Batch_Assignment__c>();
        for(Contact c : associates){
            assignmentsList.add(new Batch_Assignment__c(Associate__c = c.Id, Batch__c = batch.Id));
        }
        return assignmentsList;
    }
    
}