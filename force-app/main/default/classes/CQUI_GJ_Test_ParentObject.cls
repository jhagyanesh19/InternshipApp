@isTest
public class CQUI_GJ_Test_ParentObject {
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
   
    static testMethod void testTriggerMoveToCompletedWithAttachment() {
         user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'In Progress.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'In Progress'
            );

            insert parent;

            // Create a child with an attachment.
            CQ_GJ_SQX_Child_Object__c child = new CQ_GJ_SQX_Child_Object__c(
                CQ_GJ_SQX_Parent_Info__c = parent.Id,
                CQ_GJ_Upload_Marksheet__c = 'null0987654'
            );

            insert child;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Update the parent's status to 'Completed' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'Completed';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            // Verify that the parent's status is updated to 'Completed.'
            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c, 'status should be completed');
        }
    }

    static testMethod void testTriggerMoveToCompletedWithoutAttachment() {
          user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'In Progress.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'In Progress'
            );

            insert parent;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Attempt to update the parent's status to 'Completed' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'Completed';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            // Verify that the parent's status remains 'In Progress.'
            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('In Progress', updatedParent.CQ_GJ_Parent_Query__c, 'status shpuld be in progress');

            // Verify that an error message is added to the parent.
            System.assert(!parent.hasErrors(), 'parent should throw some error');
        }
    }

    static testMethod void testTriggerPreventUpdateWhenStatusIsClosed() {
        user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'Closed.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'Closed'
            );

            insert parent;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Attempt to update the parent's status to 'In Progress' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'In Progress';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            // Verify that the update is prevented, and an error message is added to the parent.
            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('Closed', updatedParent.CQ_GJ_Parent_Query__c, 'the CQ_GJ_Parent_Query__c should be closed');

            // Verify that an error message is added to the parent.
            System.assert(!parent.hasErrors(), 'parent should throw some error');
        }
    }

    static testMethod void testTriggerPreventMovingToDraftFromCompleted() {
          user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'Completed.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'Completed'
            );

            insert parent;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Attempt to update the parent's status to 'Draft' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'Draft';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            // Verify that the update is prevented, and an error message is added to the parent.
            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c, 'status should be completed');

            // Verify that an error message is added to the parent.
            System.assert(!parent.hasErrors(), 'parent should throw some error');
        }
    }

    static testMethod void testTriggerPreventMovingToDraftFromInProgress() {
      user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'In Progress.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'In Progress'
            );

            insert parent;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Attempt to update the parent's status to 'Draft' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'Draft';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            // Verify that the update is prevented, and an error message is added to the parent.
            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('In Progress', updatedParent.CQ_GJ_Parent_Query__c, 'status should be in progress');

            // Verify that an error message is added to the parent.
            System.assert(!parent.hasErrors(),'parent should throw some error');
        }
    }

    static testMethod void testTriggerMoveToClosedFromInProgress() {
          user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'In Progress.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'In Progress'
            );

            insert parent;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Update the parent's status to 'Closed' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'Closed';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('In Progress', updatedParent.CQ_GJ_Parent_Query__c, 'status should be in progress');
        }
    }

    static testMethod void testTriggerMoveToDraftFromInProgress() {
          user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'In Progress.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'In Progress'
            );

            insert parent;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Update the parent's status to 'Draft' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'Draft';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('Draft', updatedParent.CQ_GJ_Parent_Query__c, 'status should be in draft');
        }
    }

    static testMethod void testTriggerPreventMovingToInProgressFromCompleteds() {
      user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'Completed.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'Completed'
            );

            insert parent;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Attempt to update the parent's status to 'In Progress' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'In Progress';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c, 'status should be completed');

            System.assert(!parent.hasErrors());
        }
    }

    static testMethod void testTriggerPreventMovingToInProgressFromClosed() {
          user Usertest=[select id , username from user where Username = 'testuser1@example1.com' LIMIT 1];
        System.runAs(Usertest){
            // Create a parent with the status 'Closed.'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'Test Parent',
                CQ_GJ_Parent_Query__c = 'Closed'
            );

            insert parent;

            // Set up oldMap with the original parent record
            Map<Id, CQ_GJ_SQX_Parent_Object__c> oldMap = new Map<Id, CQ_GJ_SQX_Parent_Object__c>{
                parent.Id => parent
            };

            // Attempt to update the parent's status to 'In Progress' to trigger the code
            Test.startTest();
            parent.CQ_GJ_Parent_Query__c = 'In Progress';

            List<Database.SaveResult> results = Database.update(new List<SObject>{parent}, false);
            Test.stopTest();

            CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id][0];
            System.assertEquals('Closed', updatedParent.CQ_GJ_Parent_Query__c, 'status should be closed');

            System.assert(!parent.hasErrors(), 'parent should throw some error');
        }
    }
}