trigger AttemptScoreTrigger on Attempt_Score__c (before insert, before update, after insert, after update) {

    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        //validation
        AttemptScoreValidationAndUpdateHelper.validateCategoryMatchesExamAttemptType(Trigger.new);
        
        //prevent duplicates
        AttemptScoreValidationAndUpdateHelper.preventDuplicates(Trigger.new);
        
        //populate Weighted_Percent__c field
        AttemptScoreValidationAndUpdateHelper.updateAttemptScoreWeightedPercent(Trigger.new);
    } else if (Trigger.isAfter){
        Set<Id> attemptIds = new Set<Id>();
        for(Attempt_Score__c a : Trigger.new){
            attemptIds.add(a.Exam_Attempt__c);
        }
        ExamValidationAndUpdateHelper.updateExamAttemptOverallScore(attemptIds);
    }
}