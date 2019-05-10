@isTest
public class AttemptScoreValidationAndUpdateTest {

	@testSetup
    public static void makeData(){
        //create one associate
        List<Contact> associates = TestDataFactory.createNAssociates(1);
        insert associates;
        //create one batch
        List<Batch__c> batches = TestDataFactory.createNBatches(1, Date.newInstance(2019, 01, 01));
        insert batches;
        //create a batch assignment for that one associate and that one batch.
        List<Batch_Assignment__c> assignments = TestDataFactory.createBatchAssignments(associates, batches[0]);
        insert assignments;
        //create an exam attempt for that associate.
        List<Exam_Attempt__c> attempts = TestDataFactory.createExamAttempts(associates, true, Date.newInstance(2019, 01, 05));
        insert attempts;
    }   
    
    @isTest
    public static void updateAttemptScoreWeightedPercentSinglePosTest(){
        List<Exam_Attempt__c> attempts = [SELECT Id, Associate__c, Attempt_Date__c, Attempt_Number__c, Exam_Type__c FROM Exam_Attempt__c];
        List<Attempt_Score__c> scoresList = new List<Attempt_Score__c>();
        for(Exam_Attempt__c ea : attempts){
            for(Exam_Category__mdt ecmdt : [SELECT MasterLabel, Exam_Type__c, Weight__c FROM Exam_Category__mdt WHERE Exam_Type__r.MasterLabel = :ea.Exam_Type__c]){
                scoresList.add(new Attempt_Score__c(Exam_Attempt__c = ea.Id, Exam_Category__c = ecmdt.MasterLabel, Percent__c = 10));
            }
        }
        insert scoresList;
        scoresList = [SELECT Id, Exam_Attempt__c, Exam_Category__c, Percent__c, Weighted_Percent__c FROM Attempt_Score__c];
        for(Attempt_Score__c score : scoresList){
            Decimal weight = Constants.EXAM_CATEGORY_WEIGHTS.get(score.Exam_Category__c);
            Decimal weightedPercent = score.Weighted_Percent__c;
            System.assertEquals(weight*.1, weightedPercent);
        }
        
    }
    
    @isTest
    public static void validateCategoryMatchesExamAttemptTypeSinglePosTest(){
        List<Exam_Attempt__c> attempts = [SELECT Id, Associate__c, Attempt_Date__c, Attempt_Number__c, Exam_Type__c FROM Exam_Attempt__c];
        List<Attempt_Score__c> scoresList = new List<Attempt_Score__c>();
        for(Exam_Attempt__c ea : attempts){
            for(Exam_Category__mdt ecmdt : [SELECT MasterLabel, Exam_Type__c, Weight__c FROM Exam_Category__mdt WHERE Exam_Type__r.MasterLabel != :ea.Exam_Type__c]){
                scoresList.add(new Attempt_Score__c(Exam_Attempt__c = ea.Id, Exam_Category__c = ecmdt.MasterLabel, Percent__c = 100));
            }
        }
        try {
            insert scoresList;
        } catch (Exception e){
            System.debug(LoggingLevel.INFO, 'An exception was thrown while trying to insert attempt score records. This was expected.');
            System.assert(e.getMessage().contains('The category you chose does not exist for the associated exam type'));
        }
        
        System.assertEquals(0, [SELECT Count() FROM Attempt_Score__c]);
        
    }
}