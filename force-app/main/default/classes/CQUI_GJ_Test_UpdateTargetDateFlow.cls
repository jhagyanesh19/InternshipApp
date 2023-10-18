@isTest
public class CQUI_GJ_Test_UpdateTargetDateFlow {

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
        insert u;

        // Assign the permission set to the user
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = u.Id,
            PermissionSetId = ps.Id
        );
        insert psa;

        return u;
    }
 

    @isTest static void testAutoLaunchedFlow() {
        System.runAs(createUserWithPermissionSet()){
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
        //stop the test
        Test.stopTest();

 // Retrieve the OutRecord variable from the flow
        CQ_GJ_SQX_Parent_Object__c outRestaurant = (CQ_GJ_SQX_Parent_Object__c)flow.getVariableValue('OutRecord');

        // Validate the expected changes on OutRecord
        System.assertEquals(Date.today().addDays(10), outRestaurant.CQ_GJ_Target_Date__c, 'Target date on OutRecord should be 10 days ahead of the current date.');
    }
    }
}