public class AttemptScoreValidationAndUpdateHelper {
    
    public static void updateAttemptScoreWeightedPercent(List<Attempt_Score__c> scores){
        for(Attempt_Score__c a : scores){
            if(a.Percent__c == null){
                a.Percent__c = 0;
            }
            a.Weighted_Percent__c = (a.Percent__c * Constants.EXAM_CATEGORY_WEIGHTS.get(a.Exam_Category__c))/100;
        }
    }
    
    public static void validateCategoryMatchesExamAttemptType(List<Attempt_Score__c> scores){
        Map<Id, Exam_Attempt__c> relatedAttempts = getRelatedExamAttemptsMap(scores);
        for(Attempt_Score__c score : scores){
            String examType = relatedAttempts.get(score.Exam_Attempt__c).Exam_Type__c;
            List<String> catList = Constants.EXAM_TYPE_TO_CATEGORY_MAP.get(examType);
            if(!catList.contains(score.Exam_Category__c)){
                score.Exam_Category__c.addError('The category you chose does not exist for the associated exam type ('+ examType + ').');
            }
        }
        
    }
    
    public static Map<Id, Exam_Attempt__c> getRelatedExamAttemptsMap(List<Attempt_Score__c> scores){
        List<Id> attemptIds = new List<Id>();
        for(Attempt_Score__c score : scores){
            attemptIds.add(score.Exam_Attempt__c);
        }
        List<Exam_Attempt__c> relatedAttempts = [SELECT Id, Exam_Type__c 
                                                FROM Exam_Attempt__c
                                                WHERE Id IN :attemptIds];
        
        return new Map<Id, Exam_Attempt__c>(relatedAttempts);
    }
    
    public static void preventDuplicates(List<Attempt_Score__c> scores){
        List<AggregateResult> arList = [SELECT COUNT(Id), Exam_Attempt__c, Exam_Category__c FROM Attempt_Score__c
                                       GROUP BY Exam_Attempt__c, Exam_Category__c];
        for(AggregateResult ar : arList){
            for(Attempt_Score__c score : scores){
                if(((Id)ar.get('Exam_Attempt__c') == score.Exam_Attempt__c) && ((String)ar.get('Exam_Category__c') == score.Exam_Category__c)){
                    if((Integer)ar.get('expr0') != null && (Integer)ar.get('expr0') != 0){
                        score.addError('This attempt already has a score for this category.');
                    }
                }
            }
        }
    }
    
}