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
    
    public static List<Exam_Attempt__c> createExamAttempts(List<Contact> associates, Boolean practice){
        List<Exam_Attempt__c> attemptList = new List<Exam_Attempt__c>();
        for(Contact c : associates){
            Exam_Attempt__c attempt = new Exam_Attempt__c();
            attempt.Associate__c = c.Id;
            attempt.Attempt_Date__c = Date.Today();
            attempt.Attempt_Number__c = 1;
            attempt.Exam_Type__c = Constants.EXAM_TYPE_PICKLIST_VALUES[0].getValue();
            attempt.RecordTypeId = Constants.EXAM_ATTEMPT_RECORD_TYPES.get(practice?'Practice':'Certification').getRecordTypeId();
            attempt.Practice_Exam_Version__c = practice?1:null;
            attemptList.add(attempt);
        }
        return attemptList;
    }
    
    public static List<Exam_Attempt__c> createExamAttempts(List<Contact> associates, Boolean practice, Date dateOfAttempt){
        List<Exam_Attempt__c> attemptList = new List<Exam_Attempt__c>();
        for(Contact c : associates){
            Exam_Attempt__c attempt = new Exam_Attempt__c();
            attempt.Associate__c = c.Id;
            attempt.Attempt_Date__c = dateOfAttempt;
            attempt.Attempt_Number__c = 1;
            attempt.Exam_Type__c = Constants.EXAM_TYPE_PICKLIST_VALUES[0].getValue();
            attempt.RecordTypeId = Constants.EXAM_ATTEMPT_RECORD_TYPES.get(practice?'Practice':'Certification').getRecordTypeId();
            attempt.Practice_Exam_Version__c = practice?1:null;
            attemptList.add(attempt);
        }
        return attemptList;
    }
    
    public static List<Attempt_Score__c> createExamAttemptScores(List<Exam_Attempt__c> attempts){
        List<Attempt_Score__c> scoresList = new List<Attempt_Score__c>();
        for(Exam_Attempt__c ea : attempts){
            for(Exam_Category__mdt ecmdt : [SELECT MasterLabel, Exam_Type__c, Weight__c FROM Exam_Category__mdt WHERE Exam_Type__r.MasterLabel = :ea.Exam_Type__c]){
                System.debug('--TestDataFactory.createExamAttemptScores--');
                System.debug('Exam_Category__c: ' + ecmdt.MasterLabel);
                System.debug('---------------------------');
                scoresList.add(new Attempt_Score__c(Exam_Attempt__c = ea.Id, Exam_Category__c = ecmdt.MasterLabel, Percent__c = 100));
            }
        }
        return scoresList;
    }
    
}