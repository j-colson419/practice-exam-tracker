public class CertificationCountHelper {

    public static void updateBatchCertificationCount(List<Batch__c> batches){
        Map<Id, Batch__c> batchMap = new Map<Id, Batch__c>(batches);
        for(AggregateResult ar : [SELECT COUNT(Id) groupCount, Batch__c, ADM_Certified__c, PD1_Certified__c FROM Batch_Assignment__c
                                  WHERE Batch__c IN :batchMap.keySet() AND (ADM_Certified__c = true OR PD1_Certified__c = true)
                                  GROUP BY Batch__c, ADM_Certified__c, PD1_Certified__c]){
                                      Id batchId = (ID)ar.get('Batch__c');
                                      if((Boolean)ar.get('ADM_Certified__c')){
                                          Integer admCount = (Integer)ar.get('groupCount');
                                          Batch__c batch = batchMap.get(batchId);
                                          batch.Number_ADM_Certified__c = admCount;
                                          batchMap.put(batchId, batch);
                                      } else if ((Boolean)ar.get('PD1_Certified__c')){
                                          Integer pd1Count = (Integer)ar.get('groupCount');
                                          Batch__c batch = batchMap.get(batchId);
                                          batch.Number_PD1_Certified__c = pd1Count;
                                          batchMap.put(batchId, batch);
                                      }
                                  }
        try {
            update batchMap.values();
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, 'Something went wrong when updating certification counts.');
            System.debug(LoggingLevel.ERROR, e.getMessage());
        }
    }
    
}