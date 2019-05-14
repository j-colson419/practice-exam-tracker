public class AttemptScoreFormController {

    @AuraEnabled
    public static void insertAttemptScores(List<Attempt_Score__c> scores){
        try{
            insert scores;
        } catch (Exception e){
            System.debug('Something went wrong while trying to insert new attempt scores.');
        }
    }
    
}