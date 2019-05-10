@isTest
public class ExamValidationAndUpdateTest {

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
    public static void updateExamAttemptDaysSinceStartSinglePosTest(){
        List<Contact> associates = [SELECT Id FROM Contact];
        //Test
		List<Exam_Attempt__c> attempts = TestDataFactory.createExamAttempts(associates, true, Date.newInstance(2019, 01, 02));
        insert attempts;
        
        //Assertions
        for(Exam_Attempt__c ea : [SELECT Days_Since_Start_Of_Batch__c FROM Exam_Attempt__c]){
            System.assertEquals(1, ea.Days_Since_Start_Of_Batch__c);
        }
        
    }
    
    @isTest
    public static void updateExamAttemptOverallScoreSinglePosTest(){
        List<Contact> associates = [SELECT Id FROM Contact];
        //create exam attempt
        List<Exam_Attempt__c> attempts = TestDataFactory.createExamAttempts(associates, true, Date.newInstance(2019, 01, 03));
        insert attempts;

        List<Attempt_Score__c> scoresForAttempt = TestDataFactory.createExamAttemptScores(attempts);
        insert scoresForAttempt;
        System.debug([SELECT Count() FROM Attempt_Score__c]);
        

        Exam_Attempt__c attempt = [SELECT Id, Overall_Score__c, Pass__c FROM Exam_Attempt__c WHERE Id = :attempts[0].Id];
        System.assertEquals(100, attempt.Overall_Score__c);
        System.assert(attempt.Pass__c);
    }
    
}