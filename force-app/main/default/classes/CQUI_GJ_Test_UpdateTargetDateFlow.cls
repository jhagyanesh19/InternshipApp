@isTest
public class CQUI_GJ_Test_UpdateTargetDateFlow {

    private static User testUser;
    @testSetup
    static void setupTestData() {
        // Create a test user
        testUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'TestUser',
            Email = 'testuser@example.com',
            Username = 'testuser1@example1.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        // Insert the test user
        insert testUser;
        // Query the PermissionSet by its name
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CQ_GJ_Common_Permission_Set' LIMIT 1];
        if (ps != null) {
            // Assign the Permission Set to the test user
            PermissionSetAssignment psAssignment = new PermissionSetAssignment(
                AssigneeId = testUser.Id,
                PermissionSetId = ps.Id
            );
            insert psAssignment;
        } else {
            System.debug('PermissionSet not found. Check the name.');
        }
    }

    @isTest static void testAutoLaunchedFlow() {
        
         user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
        // 1. Insert a test record without the expected updates from the Flow
        CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
            Name = 'Test Flow'
        );
        insert parent;

        // Set up Flow and its variables
        Flow.Interview.CQUI_GJ_DateSetter_AL_Flow flow = new Flow.Interview.CQUI_GJ_DateSetter_AL_Flow(
            new Map<String, Object> {
                'InRecord' => parent
            }
        );

        Test.startTest();

        // Execute the flow
        flow.start();

        Test.stopTest();

 

        // Retrieve the OutRecord variable from the flow
        CQ_GJ_SQX_Parent_Object__c outRestaurant = (CQ_GJ_SQX_Parent_Object__c)flow.getVariableValue('OutRecord');

        // Validate the expected changes on OutRecord
        System.assertEquals(Date.today().addDays(10), outRestaurant.CQ_GJ_Target_Date__c, 'Target date on OutRecord should be 10 days ahead of the current date.');
    }
    }
}