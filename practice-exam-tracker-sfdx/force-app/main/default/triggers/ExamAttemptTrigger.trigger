trigger ExamAttemptTrigger on Exam_Attempt__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        //update practice exam version to be 0 for certification attempts
        ExamValidationAndUpdateHelper.updatePracticeExamVersionForCertAttempts(Trigger.new);
        //Fill in Days_Since_Start_Of_Batch field
        ExamValidationAndUpdateHelper.updateExamAttemptDaysSinceStart(Trigger.new);
    } else if (Trigger.isAfter){
        //Update Associate checkboxes if the attempt was a certification attempt.
        List<Exam_Attempt__c> certAttempts = new List<Exam_Attempt__c>();
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
            for(Exam_Attempt__c ea : Trigger.new){
                if(ea.RecordTypeId == Constants.EXAM_ATTEMPT_RECORD_TYPES.get('Certification').getRecordTypeId()){
                    certAttempts.add(ea);
                }
            }
        } else if (Trigger.isDelete){
            for(Exam_Attempt__c ea : Trigger.old){
                if(ea.RecordTypeId == Constants.EXAM_ATTEMPT_RECORD_TYPES.get('Certification').getRecordTypeId()){
                    certAttempts.add(ea);
                }
            }
        }
        if(certAttempts.size() > 0){
            ExamValidationAndUpdateHelper.updateAssociateCertificationStatus(certAttempts);
        }
    }
    
}