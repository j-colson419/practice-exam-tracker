trigger AssociateTrigger on Contact (after insert, after update, after delete) {
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete)){
        Map<Id,Batch__c> batchesNeedingUpdate = new Map<Id,Batch__c>();
        if(Trigger.isDelete){
            for(Batch_Assignment__c ba : [SELECT Batch__c, Batch__r.Number_ADM_Certified__c, 
                                          Batch__r.Number_PD1_Certified__c
                                          FROM Batch_Assignment__c 
                                          WHERE Associate__c IN :Trigger.oldMap.keySet()]){
                                              batchesNeedingUpdate.put(ba.Batch__c,
                                                                       new Batch__c(Id = ba.Batch__c, 
                                                                                    Number_ADM_Certified__c = (ba.Batch__r.Number_ADM_Certified__c == null ? 0 : ba.Batch__r.Number_ADM_Certified__c),
                                                                                    Number_PD1_Certified__c = (ba.Batch__r.Number_PD1_Certified__c == null ? 0 : ba.Batch__r.Number_PD1_Certified__c))
                                                                      ); 
                                              
                                          }
        } else {
            for(Batch_Assignment__c ba : [SELECT Batch__c, Batch__r.Number_ADM_Certified__c, 
                                          Batch__r.Number_PD1_Certified__c
                                          FROM Batch_Assignment__c 
                                          WHERE Associate__c IN :Trigger.newMap.keySet()]){
                                              batchesNeedingUpdate.put(ba.Batch__c,
                                                                       new Batch__c(Id = ba.Batch__c, 
                                                                                    Number_ADM_Certified__c = (ba.Batch__r.Number_ADM_Certified__c == null ? 0 : ba.Batch__r.Number_ADM_Certified__c),
                                                                                    Number_PD1_Certified__c = (ba.Batch__r.Number_PD1_Certified__c == null ? 0 : ba.Batch__r.Number_PD1_Certified__c))
                                                                      ); 
                                              
                                          }
        }
        CertificationCountHelper.updateBatchCertificationCount(batchesNeedingUpdate.values());
    }
    
}