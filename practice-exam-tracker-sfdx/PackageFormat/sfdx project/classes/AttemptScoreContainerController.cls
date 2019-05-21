public class AttemptScoreContainerController {
    
    @AuraEnabled
    public static List<Attempt_Score__c> getRelatedScores(Id attemptId){
        Map<String, Attempt_Score__c> scoresMap = new Map<String, Attempt_Score__c>();
        for (Attempt_Score__c s : [SELECT Id, Exam_Category__c, Percent__c 
                                         FROM Attempt_Score__c 
                                   WHERE Exam_Attempt__c = :attemptId
                                   ORDER BY Exam_Category__c]){
                                       //populate a map of category names to attemptscore sobjects.
                                       //then fill in any value that is null with a template sobject.
                                       scoresMap.put(s.Exam_Category__c, s);
                                   }
        String examType = getExamTypeFromAttemptId(attemptId);
        List<String> categories = Constants.EXAM_TYPE_TO_SORTED_CATEGORY_MAP.get(examType);
        for(String s : categories){
            if(scoresMap.get(s) == null){
                scoresMap.put(s, new Attempt_Score__c(Exam_Attempt__c = attemptId, Exam_Category__c = s));
            }
        }
        
        //below is new code
        List<Attempt_Score__c> scores = new List<Attempt_Score__c>();
        for(String s : categories){
            scores.add(scoresMap.get(s));
        }
        return scores;
        //return scoresMap.values();
    }
    
    @AuraEnabled
    public static String getExamTypeFromAttemptId(Id attemptId){
        String examType = [SELECT Exam_Type__c FROM Exam_Attempt__c WHERE Id = :attemptId LIMIT 1].Exam_Type__c;
        return examType;
    }
    

    
}