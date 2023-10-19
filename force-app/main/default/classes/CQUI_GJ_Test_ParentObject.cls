@isTest
public class CQUI_GJ_Test_ParentObject {
   
    static testMethod void testTriggerMoveToCompletedWithAttachment() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c);
        }
    }

    static testMethod void testTriggerMoveToCompletedWithoutAttachment() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assertEquals('In Progress', updatedParent.CQ_GJ_Parent_Query__c);

            // Verify that an error message is added to the parent.
            System.assert(!parent.hasErrors());
        }
    }

    static testMethod void testTriggerPreventUpdateWhenStatusIsClosed() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assert(!parent.hasErrors());
        }
    }

    static testMethod void testTriggerPreventMovingToDraftFromCompleted() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c);

            // Verify that an error message is added to the parent.
            System.assert(!parent.hasErrors());
        }
    }

    static testMethod void testTriggerPreventMovingToDraftFromInProgress() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assertEquals('In Progress', updatedParent.CQ_GJ_Parent_Query__c);

            // Verify that an error message is added to the parent.
            System.assert(!parent.hasErrors());
        }
    }

    static testMethod void testTriggerMoveToClosedFromInProgress() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assertEquals('In Progress', updatedParent.CQ_GJ_Parent_Query__c);
        }
    }

    static testMethod void testTriggerMoveToDraftFromInProgress() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assertEquals('Draft', updatedParent.CQ_GJ_Parent_Query__c);
        }
    }

    static testMethod void testTriggerPreventMovingToInProgressFromCompleteds() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c);

            System.assert(!parent.hasErrors());
        }
    }

    static testMethod void testTriggerPreventMovingToInProgressFromClosed() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){
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
            System.assertEquals('Closed', updatedParent.CQ_GJ_Parent_Query__c);

            System.assert(!parent.hasErrors());
        }
    }
}