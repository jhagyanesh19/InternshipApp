@isTest
public class CQUI_GJ_Test_ChildObject {



    @isTest
    static void testPreventer() {
        System.runAs(createUserWithPermissionSet()){
            //Iam running as testUser
        // Assuming you have a CQ_GJ_SQX_Parent_Object__c object that is being referred to by the child object
        CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
            Name = 'TestParent',
            CQ_GJ_Parent_Query__c = 'Draft'
        );
        insert parent;

        CQ_GJ_SQX_Child_Object__c child = new CQ_GJ_SQX_Child_Object__c(
            Name = 'TestChild',
            CQ_GJ_SQX_Parent_Info__c = parent.Id
        );
        insert child;

 

        // Try updating child when parent status is 'Draft' - should not throw error
        Test.startTest();
        try {
            child.Name = 'TestChildUpdated';
            update child;
        } catch (Exception e) {
            System.assert(false, child.hasErrors());
        }
        Test.stopTest();

        // Update parent status to 'Completed'
        parent.CQ_GJ_Parent_Query__c = 'Completed';
        update parent;

 

        // Try updating child now - should throw error
        Boolean errorThrown = false;
        try {
            child.Name = 'TestChildUpdated2';
            update child;
        } catch (DmlException e) {
            errorThrown = e.getMessage().contains('Updation/Insertion of the child record at this stage is not allowed.');
        }
        System.assert(errorThrown, 'Expected exception not thrown');
    }
    }

 

    @isTest
    static void testHandleBeforeDelete() {
        System.runAs(createUserWithPermissionSet()){
        CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
            Name = 'TestParent',
            CQ_GJ_Parent_Query__c = 'Draft'
        );
        insert parent;

        CQ_GJ_SQX_Child_Object__c child = new CQ_GJ_SQX_Child_Object__c(
            Name = 'TestChild',
            CQ_GJ_SQX_Parent_Info__c = parent.Id
        );
        insert child;

 

        // Try deleting child when parent status is 'Draft' - should not throw error
        Test.startTest();
        try {
            delete child;
        } catch (Exception e) {
            System.assertEquals(child.hasErrors(),false, 'Error' );
        }
        Test.stopTest();

        // Insert child again for next test
       

 

        // Update parent status to 'Completed'
        parent.CQ_GJ_Parent_Query__c = 'Completed';
        update parent;

 

        // Try deleting child now - should throw error
       
        try {
            delete child;
        } catch (DmlException e) {
           boolean t= e.getMessage().contains('Sorry, Deletion of child is not allowed when the parent status is moved from Draft');
       
           System.assertEquals(t,true, 'Something error' );
        }
        }
    }
    private static User createUserWithPermissionSet() {

        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CQ_GJ_Common_Permission_Set' LIMIT 1];

        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1]; 

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
}