@isTest
public class ExamValidationAndUpdateTest {

    @isTest
    public static void updateExamAttemptDaysSinceStartSinglePosTest(){
        //data setup
        List<Contact> associates = TestDataFactory.createNAssociates(1);
        insert associates;
        
        List<Batch__c> batches = TestDataFactory.createNBatches(1, Date.newInstance(2019, 01, 01));
        insert batches;
        
        List<Batch_Assignment__c> assignments = TestDataFactory.createBatchAssignments(associates, batches[0]);
        insert assignments;
        
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
        
    }
    
}