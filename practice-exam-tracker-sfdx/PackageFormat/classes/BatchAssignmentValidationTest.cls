@isTest
public class BatchAssignmentValidationTest {

    @TestSetup
    static void makeData(){
        //create one associate
        List<Contact> associates = TestDataFactory.createNAssociates(1);
        insert associates;
        //create one batch
        List<Batch__c> batches = TestDataFactory.createNBatches(1, Date.newInstance(2019, 01, 01));
        insert batches;
        //create a batch assignment for that one associate and that one batch.
        List<Batch_Assignment__c> assignments = TestDataFactory.createBatchAssignments(associates, batches[0]);
        insert assignments;
    }
    
    @isTest
    public static void preventDupsSinglePosTest(){
        Contact associate = [SELECT Id FROM Contact LIMIT 1];
        Batch__c batch = [SELECT Id FROM Batch__c LIMIT 1];
        Batch_Assignment__c assignmentDup = new Batch_Assignment__c(Associate__c = associate.Id, Batch__c = batch.Id);
        try {
            insert assignmentDup;
        } catch (Exception e){
            System.debug('As expected, something went wrong while trying to insert a duplicate Batch Assignment.');
            System.assert(e.getMessage().contains('This associate is already assigned to this batch.'));
        }
    }
    
}