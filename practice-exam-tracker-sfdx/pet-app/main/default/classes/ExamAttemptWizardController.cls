public class ExamAttemptWizardController {

    @AuraEnabled
    public static List<RecordType> getAttemptRecordTypes(){
        return [SELECT Id, Name FROM RecordType WHERE SobjectType='Exam_Attempt__c'];
    }
    
}