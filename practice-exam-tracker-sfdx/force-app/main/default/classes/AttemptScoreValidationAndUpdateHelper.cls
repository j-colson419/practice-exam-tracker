public class AttemptScoreValidationAndUpdateHelper {

    public static void updateAttemptScoreWeightedPercent(List<Attempt_Score__c> scores){
        System.debug('--AttemptScoreValidationAndUpdateHelper.updateAttemptScoreWeightedPercent--');
        System.debug('Input list of scores: ' + scores);
        
        for(Attempt_Score__c a : scores){
            System.debug('Exam_Category__c: ' + ((a.Exam_Category__c== null)?'is Null': a.Exam_Category__c));
            if(a.Percent__c == null){
                a.Percent__c = 0;
            }
            System.debug('Associate Weight: ' + Constants.EXAM_CATEGORY_WEIGHTS.get(a.Exam_Category__c));
            System.debug('Percent * Weight: ' + a.Percent__c * Constants.EXAM_CATEGORY_WEIGHTS.get(a.Exam_Category__c));
            a.Weighted_Percent__c = (a.Percent__c * Constants.EXAM_CATEGORY_WEIGHTS.get(a.Exam_Category__c))/100;
        }
        System.debug('-------------------------');
    }
    
}