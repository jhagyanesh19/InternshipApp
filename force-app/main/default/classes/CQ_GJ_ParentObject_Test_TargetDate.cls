@isTest
public class CQ_GJ_ParentObject_Test_TargetDate {
private static User createUserWithPermissionSet() {
		//frtching te permission sets
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CQ_GJ_Common_Permission_Set' LIMIT 1];
		//getting the profile
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1]; 
		//creating   new user
        User u = new User(
            ProfileId = p.Id,
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'standaruser@testo1rg.com'
        );
    //inserting that user
        insert u;

        // Assign the permission set to the user
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = u.Id,
            PermissionSetId = ps.Id
        );
        insert psa;

        return u;
    }


    private static final String VAL_ERROR_MESSAGE = 'Sorry, initial date can not be ahead of target date';

    @isTest static void testDateCondition() {
        //running the method as User
        System.runas(createUserWithPermissionSet()){

            // Create a test record with CQ_NN_Initiated_Date__c >= CQ_NN_Target_Date__c
             CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Initiated_Date__c = Date.today(),
                CQ_GJ_Target_Date__c = Date.today().addDays(-1) // Making target date 1 day before the initiated date
            );

            Exception expectedException;
            try {
                //trying to isert the parent
                insert parent;
            } catch (System.DmlException e) {
                expectedException = e;
            }

            // Assertions
            System.assertNotEquals(null, expectedException, 'A DML Exception should have been thrown due to the validation rule.');
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', expectedException.getDmlType(0).name(), 'Expected a custom validation exception.');
            System.assert(expectedException.getMessage().contains(VAL_ERROR_MESSAGE), 'Custom error message should be displayed.');
        }
    }
}