public class ExamValidationAndUpdateHelper {
    
    public static Map<Id, Date> getBatchStartDateByAssociate(Set<Id> associateIds){
        Map<Id, Date> associateIdStartDateMap = new Map<Id, Date>();
        
        for(Batch_Assignment__c ba : [SELECT Associate__c, Batch__r.Start_Date__c FROM Batch_Assignment__c
                                      WHERE Associate__c IN :associateIds]){
                                          associateIdStartDateMap.put(ba.Associate__c, ba.Batch__r.Start_Date__c);
                                      }
        return associateIdStartDateMap;
    }
    
    public static void updateExamAttemptDaysSinceStart(List<Exam_Attempt__c> attemptsList){
        Map<Id, Exam_Attempt__c> associateIdToExamAttemptMap = new Map<Id, Exam_Attempt__c>();
        for(Exam_Attempt__c ea : attemptsList){
            associateIdToExamAttemptMap.put(ea.Associate__c, ea);
        }
        Map<Id, Date> associateIdStartDateMap = getBatchStartDateByAssociate(associateIdToExamAttemptMap.keySet());
        //Map<Id, Exam_Attempt__c> examAttemptMap = new Map<Id, Exam_Attempt__c>();
        for(Id i : associateIdStartDateMap.keySet()){
            for(Exam_Attempt__c ea : attemptsList){
                if(ea.Associate__c == i){
                    ea.Days_Since_Start_Of_Batch__c = associateIdStartDateMap.get(i).daysBetween(ea.Attempt_Date__c);
                }
            }
        }
        //return examAttemptMap;
    }  

    public static void updateAssociateCertificationStatus(List<Exam_Attempt__c> attemptsList){
        Set<Id> associateIds = new Set<Id>();
        List<Contact> associatesToUpdate = new List<Contact>();
        for(Exam_Attempt__c ea : attemptsList){
            associateIds.add(ea.Associate__c);
        }
        List<AggregateResult> arList = [SELECT COUNT(Id), Exam_Type__c, Associate__c 
                                        FROM Exam_Attempt__c 
                                        WHERE Pass__c = true 
                                        AND Associate__c IN :associateIds 
                                        AND RecordTypeId = :Constants.EXAM_ATTEMPT_RECORD_TYPES.get('Certification').getRecordTypeId()
                                        GROUP BY Associate__c, Exam_Type__c];
        for(Id aId : associateIds){
            Contact a = new Contact(Id = aId, Admin_Certified__c = false, PD1_Certified__c = false);
            for(AggregateResult ar : arList){
                if(aId == (Id)ar.get('Associate__c') && (String)ar.get('Exam_Type__c') == 'ADM 201' ){
                  a.Admin_Certified__c = true;
                } else if (aId == (Id)ar.get('Associate__c') && (String)ar.get('Exam_Type__c') ==  'PD1'){
                    a.PD1_Certified__c = true;
                }
            }
            associatesToUpdate.add(a);
        }
        try {
            update associatesToUpdate;
        } catch (Exception e){
            System.debug('Something went wrong while trying to update the certification status of an Associate record.');
        }
    }
    
    public static void updateExamAttemptOverallScore(Set<ID> attemptIds){
        List<Exam_Attempt__c> attemptsToUpdate = new List<Exam_Attempt__c>();
        for(AggregateResult ar : [SELECT SUM(Weighted_Percent__c), Exam_Attempt__c FROM Attempt_Score__c
                                  WHERE Exam_Attempt__c IN :attemptIds
                                  GROUP BY Exam_Attempt__c]){
                                      System.debug('Overall Score: ' + (Decimal)ar.get('expr0'));
                                      attemptsToUpdate.add(new Exam_Attempt__c(Id = (Id)ar.get('Exam_Attempt__c'),
                                                                               Overall_Score__c = (Decimal)ar.get('expr0')));   
                                  }
        try {
            update attemptsToUpdate;
        } catch (Exception e){
            System.debug('Something went wrong while trying to update the overall score of exam attempts.');
        }
    }
    
    public static void updatePracticeExamVersionForCertAttempts(List<Exam_Attempt__c> attempts){
        for(Exam_Attempt__c ea : attempts){
            if(ea.RecordTypeId == Constants.EXAM_ATTEMPT_RECORD_TYPES.get('Certification').getRecordTypeId()){
                ea.Practice_Exam_Version__c = 0;
            }
        }
    }
    
}