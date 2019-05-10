public class AttemptScoreValidationAndUpdateHelper {
    
    public static void updateAttemptScoreWeightedPercent(List<Attempt_Score__c> scores){
        for(Attempt_Score__c a : scores){
            if(a.Percent__c == null){
                a.Percent__c = 0;
            }
            a.Weighted_Percent__c = (a.Percent__c * Constants.EXAM_CATEGORY_WEIGHTS.get(a.Exam_Category__c))/100;
        }
    }
    
}