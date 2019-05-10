trigger ExamAttemptTrigger on Exam_Attempt__c (before insert, before update, after insert, after update) {

    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        //Fill in Days_Since_Start_Of_Batch field
        ExamValidationAndUpdateHelper.updateExamAttemptDaysSinceStart(Trigger.new);
    } else if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        //Update Associate checkboxes if the attempt was a certification attempt and was passed.
        List<Exam_Attempt__c> passedCertAttempts = new List<Exam_Attempt__c>();
        for(Exam_Attempt__c ea : Trigger.new){
            if(ea.Pass__c && ea.RecordTypeId == Constants.EXAM_ATTEMPT_RECORD_TYPES.get('Certification').getRecordTypeId()){
                passedCertAttempts.add(ea);
            }
        }
        ExamValidationAndUpdateHelper.updateAssociateCertificationStatus(passedCertAttempts);
    }
    
}