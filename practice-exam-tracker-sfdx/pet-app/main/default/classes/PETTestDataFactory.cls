@isTest
public class PETTestDataFactory {
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
                scoresList.add(new Attempt_Score__c(Exam_Attempt__c = ea.Id, Exam_Category__c = ecmdt.MasterLabel, Percent__c = 100));
            }
        }
        return scoresList;
    }
    
    public static List<Attempt_Score__c> createExamAttemptScores(List<Exam_Attempt__c> attempts, Boolean passing){
        List<Attempt_Score__c> scoresList = new List<Attempt_Score__c>();
        for(Exam_Attempt__c ea : attempts){
            for(Exam_Category__mdt ecmdt : [SELECT MasterLabel, Exam_Type__c, Weight__c FROM Exam_Category__mdt WHERE Exam_Type__r.MasterLabel = :ea.Exam_Type__c]){
                if(passing){
                    scoresList.add(new Attempt_Score__c(Exam_Attempt__c = ea.Id, Exam_Category__c = ecmdt.MasterLabel, Percent__c = 100));
                } else {
                    scoresList.add(new Attempt_Score__c(Exam_Attempt__c = ea.Id, Exam_Category__c = ecmdt.MasterLabel, Percent__c = 1));
                }
            
            }
        }
        return scoresList;
    }
}
