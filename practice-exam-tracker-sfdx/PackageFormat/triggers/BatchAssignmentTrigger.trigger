trigger BatchAssignmentTrigger on Batch_Assignment__c (before insert, before update) {

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        BatchAssignmentValidationHelper.preventDuplicates(Trigger.new);
    }
    
}