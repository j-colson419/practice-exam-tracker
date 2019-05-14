public class AttemptScoreFormController {

    @AuraEnabled
    public static void upsertAttemptScores(List<Attempt_Score__c> scores){
        try{
            upsert scores;
        } catch (Exception e){
            System.debug('Something went wrong while trying to insert new attempt scores.');
        }
    }
    
}