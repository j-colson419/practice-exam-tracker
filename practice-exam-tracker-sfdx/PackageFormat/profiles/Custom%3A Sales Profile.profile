<?xml version="1.0" encoding="UTF-8"?>
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <applicationVisibilities>
        <application>Practice_Exam_Tracker</application>
        <default>false</default>
        <visible>false</visible>
    </applicationVisibilities>
    <classAccesses>
        <apexClass>AssociateMassStageUpdateController</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>AttemptScoreValidationAndUpdateHelper</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>AttemptScoreValidationAndUpdateTest</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>CertificationCountHelper</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>CertificationCountHelperTest</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>Constants</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>ExamCategoryWeightWrapper</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>ExamValidationAndUpdateHelper</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>ExamValidationAndUpdateTest</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>TestDataFactory</apexClass>
        <enabled>false</enabled>
    </classAccesses>
    <custom>true</custom>
    <fieldPermissions>
        <editable>false</editable>
        <field>Attempt_Score__c.Percent__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Attempt_Score__c.Weighted_Percent__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Batch_Assignment__c.ADM_Certified__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Batch_Assignment__c.Associate_Name__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Batch_Assignment__c.PD1_Certified__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Batch__c.Length__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Batch__c.Number_ADM_Certified__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Batch__c.Number_PD1_Certified__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Contact.Admin_Certified__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Contact.Master_Stage__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Contact.PD1_Certified__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Exam_Attempt__c.Days_Since_Start_Of_Batch__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Exam_Attempt__c.Exam_Version__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Exam_Attempt__c.Overall_Score__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Exam_Attempt__c.Pass__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Exam_Attempt__c.Practice_Exam_Version__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Exam_Type__mdt.Certification_Name__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <layoutAssignments>
        <layout>Attempt_Score__c-Attempt Score Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Batch_Assignment__c-Batch Assignment Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Batch__c-Batch Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Contact-Contact %28Sales%29 Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Exam_Attempt__c-Certification Exam Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Exam_Attempt__c-Certification Exam Layout</layout>
        <recordType>Exam_Attempt__c.Certification</recordType>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Exam_Attempt__c-Certification Exam Layout</layout>
        <recordType>Exam_Attempt__c.Practice</recordType>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Exam_Category__mdt-Exam Category Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Exam_Type__mdt-Exam Type Layout</layout>
    </layoutAssignments>
    <recordTypeVisibilities>
        <default>false</default>
        <recordType>Exam_Attempt__c.Certification</recordType>
        <visible>false</visible>
    </recordTypeVisibilities>
    <recordTypeVisibilities>
        <default>false</default>
        <recordType>Exam_Attempt__c.Practice</recordType>
        <visible>false</visible>
    </recordTypeVisibilities>
    <tabVisibilities>
        <tab>Associate_Master_Stage_Update</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>Attempt_Score__c</tab>
        <visibility>Hidden</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>Batch__c</tab>
        <visibility>Hidden</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>Exam_Attempt__c</tab>
        <visibility>Hidden</visibility>
    </tabVisibilities>
    <userLicense>Salesforce</userLicense>
    <userPermissions>
        <enabled>true</enabled>
        <name>ActivitiesAccess</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>AllowViewKnowledge</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ApexRestServices</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ApiEnabled</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>AssignTopics</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ChatterInternalUser</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ChatterInviteExternalUsers</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ChatterOwnGroups</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ConvertLeads</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>CreateCustomizeFilters</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>CreateCustomizeReports</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>CreateTopics</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>DistributeFromPersWksp</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>EditEvent</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>EditOppLineItemUnitPrice</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>EditTask</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>EditTopics</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>EmailMass</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>EmailSingle</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>EnableNotifications</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ExportReport</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ImportPersonal</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>LightningConsoleAllowedForUser</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ListEmailSend</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ManageEncryptionKeys</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>RunReports</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>SelectFilesFromSalesforce</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>SendSitRequests</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ShowCompanyNameAsUserBadge</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>SubmitMacrosAllowed</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>SubscribeToLightningReports</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>TransactionalEmailSend</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>UseWebLink</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ViewEventLogFiles</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ViewHelpLink</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ViewRoles</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ViewSetup</name>
    </userPermissions>
</Profile>
