public class NewWeekFormController {

    @AuraEnabled
    public static Map<Id, String> getAvailableTopics(){
        Map<Id, String> availTopics = new Map<Id, String>();
        for(Question_Topic__c qt : [SELECT Id, Name FROM Question_Topic__c WHERE Active__c = true]){
            availTopics.put(qt.Id, qt.Name);
        }
        return availTopics;
    }
    
    @AuraEnabled
    public static Map<Id, String> getAvailableSubtopics(){
        Map<Id, String> availSubtopics = new Map<Id, String>();
        for(Question_Subtopic__c qs : [SELECT Id, Name FROM Question_Subtopic__c WHERE Active__c = true]){
            availSubtopics.put(qs.Id, qs.Name);
        }
        return availSubtopics;
    }
    
}