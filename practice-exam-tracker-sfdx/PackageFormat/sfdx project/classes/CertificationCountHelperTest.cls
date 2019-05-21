@isTest
public class CertificationCountHelperTest {

    @testSetup
    public static void setup(){
        Batch__c batch = new Batch__c(Name = '190311-Salesforce', Start_Date__c = Date.newInstance(2019, 03, 11), Length__c = 10);
        insert batch;
        
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < 5; i++){
            Contact con = new Contact(LastName = 'Test ' + i);
            contacts.add(con);
        }
        insert contacts;
        
        List<Batch_Assignment__c> assignments = new List<Batch_Assignment__c>();
        for(Contact con : contacts){
            assignments.add(new Batch_Assignment__c(Associate__c = con.Id, Batch__c = batch.Id));
        }
        insert assignments;
    }
    
    @isTest
    public static void singlePositiveUpdateBatchCertificationCountTest(){
        List<Contact> associates = [SELECT Id, Admin_Certified__c, PD1_Certified__c FROM Contact];
        for(Contact c : associates){
            c.Admin_Certified__c = true;
        }
        update associates;
        
        Batch__c batch = [SELECT Id, Number_ADM_Certified__c, Number_PD1_Certified__c FROM Batch__c LIMIT 1];
        System.assertEquals(5, batch.Number_ADM_Certified__c);
        System.assertEquals(0, batch.Number_PD1_Certified__c);
    }
    
}