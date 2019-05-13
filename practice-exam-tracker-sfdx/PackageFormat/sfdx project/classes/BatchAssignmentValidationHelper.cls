public class BatchAssignmentValidationHelper {

    public static void preventDuplicates(List<Batch_Assignment__c> assignments){
        List<AggregateResult> arList = [SELECT COUNT(Id), Batch__c, Associate__c FROM Batch_Assignment__c
                                       GROUP BY Batch__c, Associate__c];
        for(AggregateResult ar : arList){
            for(Batch_Assignment__c ba : assignments){
                if(((Id)ar.get('Batch__c') == ba.Batch__c) && ((Id)ar.get('Associate__c') == ba.Associate__c)){
                    if((Integer)ar.get('expr0') != null && (Integer)ar.get('expr0') != 0){
                        ba.addError('This associate is already assigned to this batch.');
                    }
                }
            }
        }
    }
    
}