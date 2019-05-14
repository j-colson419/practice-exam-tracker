public class AttemptScoreContainerController {

    @AuraEnabled
    public static List<Attempt_Score__c> getRelatedScores(Id attemptId){
        List<Attempt_Score__c> scores = [SELECT Id, Exam_Category__c, Percent__c 
                                         FROM Attempt_Score__c 
                                         WHERE Exam_Attempt__c = :attemptId];
        if(scores == null || scores.size() == 0){
            String examType = getExamTypeFromAttemptId(attemptId);
            scores = getAttemptScoreTemplatesForExamType(examType, attemptId);
        }
        return scores;
    }
    
    @AuraEnabled
    public static String getExamTypeFromAttemptId(Id attemptId){
    	String examType = [SELECT Exam_Type__c FROM Exam_Attempt__c WHERE Id = :attemptId].Exam_Type__c;
        return examType;
    }
    
    @AuraEnabled
    public static List<Attempt_Score__c> getAttemptScoreTemplatesForExamType(String examType, Id attemptId){
        List<Attempt_Score__c> scores = new List<Attempt_Score__c>();
        for(String s : Constants.EXAM_TYPE_TO_CATEGORY_MAP.get(examType)){
            Attempt_Score__c score = new Attempt_Score__c(Exam_Attempt__c = attemptId, Exam_Category__c = s, Percent__c = null);
            scores.add(score);
        }
        return scores;
    }
    
}