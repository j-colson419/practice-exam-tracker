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
    
    @AuraEnabled
    public static void createWeekAndTopicsCoveredForBatch(Week__c newWeek, List<Id> topicsCovered, List<Id> subtopicsCovered){
        try {
            insert newWeek;
            createTopicsCoveredForWeek(newWeek.Id, topicsCovered, subtopicsCovered);
        } catch (Exception e){
            throw new AuraHandledException('An exception was thrown while trying to insert a new week record.');
        }
    }
    
    @AuraEnabled
    public static void createTopicsCoveredForWeek(Id weekId, List<Id> topicsCovered, List<Id> subtopicsCovered){
        List<Topic_Covered__c> toInsert = new List<Topic_Covered__c>();
        if(topicsCovered != null && topicsCovered.size() > 0){
            for(Id i : topicsCovered){
                toInsert.add(new Topic_Covered__c(Week__c = weekId, Topic_Covered__c = i));
            }
        }
        if(subtopicsCovered != null && subtopicsCovered.size() > 0){
            for(Id i : subtopicsCovered){
                toInsert.add(new Topic_Covered__c(Week__c = weekId, Subtopic_Covered__c = i));
            }
        }
        try {
            if(toInsert.size() != 0){
                insert toInsert;
                System.debug(toInsert);
                System.debug('Success!');
            }
        } catch(Exception e){
            throw new AuraHandledException('An exception was thrown while trying to insert a topic covered records.');
        }
        
    }
    
}