public class Constants {
    
    public static final List<Schema.PicklistEntry> EXAM_TYPE_PICKLIST_VALUES {
        get {
            if(EXAM_TYPE_PICKLIST_VALUES == null){
                EXAM_TYPE_PICKLIST_VALUES = Schema.SObjectType.Exam_Attempt__c.fields.Exam_Type__c.getPicklistValues();
            }
            return EXAM_TYPE_PICKLIST_VALUES;
        }
        set;
    } 
    
    public static final Map<String, Schema.PicklistEntry> EXAM_TYPE_PICKLIST_MAP{
        get {
            if(EXAM_TYPE_PICKLIST_MAP == null){
                EXAM_TYPE_PICKLIST_MAP = new Map<String, Schema.PicklistEntry>();
                for(Schema.PicklistEntry pe : EXAM_TYPE_PICKLIST_VALUES){
                    EXAM_TYPE_PICKLIST_MAP.put(pe.getLabel(), pe);
                }
            }
            
            return EXAM_TYPE_PICKLIST_MAP;
        }
        set;
    }
    
    public static final List<Schema.PicklistEntry> EXAM_CATEGORY_PICKLIST_VALUES {
        get {
            if(EXAM_CATEGORY_PICKLIST_VALUES == null){
                EXAM_CATEGORY_PICKLIST_VALUES = Schema.SObjectType.Attempt_Score__c.fields.Exam_Category__c.getPicklistValues();
            }
            return EXAM_CATEGORY_PICKLIST_VALUES;
        }
        set;
    }
    
    public static final Map<String, Schema.PicklistEntry> EXAM_CATEGORY_PICKLIST_MAP{
        get {
            EXAM_CATEGORY_PICKLIST_MAP = new Map<String, Schema.PicklistEntry>();
            for(Schema.PicklistEntry pe : EXAM_CATEGORY_PICKLIST_VALUES){
                EXAM_CATEGORY_PICKLIST_MAP.put(pe.getLabel(), pe);
            }
            return EXAM_CATEGORY_PICKLIST_MAP;
        }
        set;
    }
    
    public static final List<Exam_Category__mdt> EXAM_CATEGORY_METADATA_RECORDS {
        get {
            if(EXAM_CATEGORY_METADATA_RECORDS == null){
                EXAM_CATEGORY_METADATA_RECORDS = [SELECT MasterLabel, Exam_Type__c, Weight__c
                                                  FROM Exam_Category__mdt];
            }
            return EXAM_CATEGORY_METADATA_RECORDS;
        }
        set;
    } 
    
    public static final Map<String, List<String>> EXAM_TYPE_TO_CATEGORY_MAP {
        get{
            EXAM_TYPE_TO_CATEGORY_MAP = new Map<String, List<String>>();
            List<Exam_Type__mdt> examTypeRecords = [SELECT MasterLabel, Id FROM Exam_Type__mdt];
            Map<Id, Exam_Type__mdt> examTypeMap = new Map<Id, Exam_Type__mdt>(examTypeRecords);
            for(Exam_Category__mdt ec : EXAM_CATEGORY_METADATA_RECORDS){
                if(EXAM_TYPE_TO_CATEGORY_MAP.containsKey(examTypeMap.get(ec.Exam_Type__c).MasterLabel)){
                    List<String> catList = EXAM_TYPE_TO_CATEGORY_MAP.get(examTypeMap.get(ec.Exam_Type__c).MasterLabel);
                    catList.add(ec.MasterLabel);
                    EXAM_TYPE_TO_CATEGORY_MAP.put(examTypeMap.get(ec.Exam_Type__c).MasterLabel, catList);
                } else {
                    List<String> catList = new List<String>();
                    catList.add(ec.MasterLabel);
                    EXAM_TYPE_TO_CATEGORY_MAP.put(examTypeMap.get(ec.Exam_Type__c).MasterLabel, catList);
                }
            }
            return EXAM_TYPE_TO_CATEGORY_MAP;
        }
        set;
    }
    
    public static final Map<String, List<String>> EXAM_TYPE_TO_SORTED_CATEGORY_MAP {
        get{
            if(EXAM_TYPE_TO_SORTED_CATEGORY_MAP == null){
                EXAM_TYPE_TO_SORTED_CATEGORY_MAP = new Map<String, List<String>>();
                Map<Id, Exam_Type__mdt> examTypeMap = new Map<Id, Exam_Type__mdt>([SELECT MasterLabel, Id FROM Exam_Type__mdt]);
                for(Exam_Category__mdt ec : SORTED_EXAM_CATEGORY_MD_RECORDS){
                    if(EXAM_TYPE_TO_SORTED_CATEGORY_MAP.containsKey(examTypeMap.get(ec.Exam_Type__c).MasterLabel)){
                        List<String> catList = EXAM_TYPE_TO_SORTED_CATEGORY_MAP.get(examTypeMap.get(ec.Exam_Type__c).MasterLabel);
                        catList.add(ec.MasterLabel);
                        EXAM_TYPE_TO_SORTED_CATEGORY_MAP.put(examTypeMap.get(ec.Exam_Type__c).MasterLabel, catList);
                    } else {
                        List<String> catList = new List<String>();
                        catList.add(ec.MasterLabel);
                        EXAM_TYPE_TO_SORTED_CATEGORY_MAP.put(examTypeMap.get(ec.Exam_Type__c).MasterLabel, catList);
                    }
                }
            }
            
            return EXAM_TYPE_TO_SORTED_CATEGORY_MAP;
        }
        set;
    }
    
    public static final List<Exam_Category__mdt> SORTED_EXAM_CATEGORY_MD_RECORDS {
        get {
            if(SORTED_EXAM_CATEGORY_MD_RECORDS == null){
                SORTED_EXAM_CATEGORY_MD_RECORDS = new List<Exam_Category__mdt>();
                for(Schema.PicklistEntry pe : EXAM_CATEGORY_PICKLIST_VALUES){
                    for(Exam_Category__mdt ec : EXAM_CATEGORY_METADATA_RECORDS){
                        if(ec.MasterLabel == pe.getLabel()){
                            SORTED_EXAM_CATEGORY_MD_RECORDS.add(ec);
                        }
                    }
                }
            }
            return SORTED_EXAM_CATEGORY_MD_RECORDS;
        }
        set;
    }
    
    public static final Map<String, Decimal> EXAM_CATEGORY_WEIGHTS {
        get{
            if(EXAM_CATEGORY_WEIGHTS == null){
                EXAM_CATEGORY_WEIGHTS = new Map<String, Decimal>();
                for(Exam_Category__mdt ecmdt : EXAM_CATEGORY_METADATA_RECORDS){
                    for(String s : EXAM_CATEGORY_PICKLIST_MAP.keySet()){
                        if(ecmdt.MasterLabel == s){
                            EXAM_CATEGORY_WEIGHTS.put(s, ecmdt.Weight__c);
                        }
                    }
                }
            }
            return EXAM_CATEGORY_WEIGHTS;
        }
        set;
    }
    
    public static final Map<String, Schema.RecordTypeInfo> EXAM_ATTEMPT_RECORD_TYPES {
        get {
            if(EXAM_ATTEMPT_RECORD_TYPES == null){
                EXAM_ATTEMPT_RECORD_TYPES = Schema.SObjectType.Exam_Attempt__c.getRecordTypeInfosByDeveloperName();
            }
            return EXAM_ATTEMPT_RECORD_TYPES;
        }
        set;
    } 
    
}