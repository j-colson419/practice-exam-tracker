trigger AttemptScoreTrigger on Attempt_Score__c (before insert, before update) {

    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        AttemptScoreValidationAndUpdateHelper.updateAttemptScoreWeightedPercent(Trigger.new);
    } else if (Trigger.isAfter){
        Set<Id> attemptIds = new Set<Id>();
        for(Attempt_Score__c a : Trigger.new){
            attemptIds.add(a.Exam_Attempt__c);
        }
        ExamValidationAndUpdateHelper.updateExamAttemptOverallScore(attemptIds);
    }
}