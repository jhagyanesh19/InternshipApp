@isTest
public class CQUI_GJ_Test_ChildObject {

 

    @isTest
    static void testPreventer() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){

            // Create parent record with status 'Draft'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'TestParent',
                CQ_GJ_Parent_Query__c = 'Draft'
            );
            insert parent;

            // Create child record and associate with the parent
            CQ_GJ_SQX_Child_Object__c child = new CQ_GJ_SQX_Child_Object__c(
                Name = 'TestChild',
                CQ_GJ_SQX_Parent_Info__c = parent.Id
            );
            insert child;

            // Update child when parent status is 'Draft' - should not throw error
            Test.startTest();
            child.Name = 'TestChildUpdated';
            Database.SaveResult result = Database.update(child, false);
            System.assert(result.isSuccess(), 'Error occurred while updating child with parent status as Draft');
            Test.stopTest();

            // Update parent status to 'Completed'
            parent.CQ_GJ_Parent_Query__c = 'Completed';
            update parent;

            // Update child now - an error is expected as the parent status is 'Completed'
            child.Name = 'TestChildUpdated2';
            Database.SaveResult result2 = Database.update(child, false);
            System.assert(!result2.isSuccess() && result2.getErrors()[0].getMessage().contains('Updation/Insertion of the child record at this stage is not allowed.'), 'Expected exception not thrown');
        }
    }

 

    @isTest
    static void testHandleBeforeDelete() {
        System.runAs(FetchTestUser.createUserWithPermissionSet()){

            // Create parent record with status 'Draft'
            CQ_GJ_SQX_Parent_Object__c parent = new CQ_GJ_SQX_Parent_Object__c(
                Name = 'TestParent',
                CQ_GJ_Parent_Query__c = 'Draft'
            );
            insert parent;

            // Create child record and associate with the parent
            CQ_GJ_SQX_Child_Object__c child = new CQ_GJ_SQX_Child_Object__c(
                Name = 'TestChild',
                CQ_GJ_SQX_Parent_Info__c = parent.Id
            );
            insert child;

            // Delete child when parent status is 'Draft' - should not throw error
            Test.startTest();
            Database.DeleteResult deleteResult = Database.delete(child, false);
            System.assert(deleteResult.isSuccess(), 'Error occurred while deleting child with parent status as Draft');
            Test.stopTest();

            // Insert child again for the next test scenario
             CQ_GJ_SQX_Child_Object__c child1 = new CQ_GJ_SQX_Child_Object__c(
                Name = 'TestChild12s',
                CQ_GJ_SQX_Parent_Info__c = parent.Id,
                 CQ_GJ_Upload_Marksheet__c = 'null0987654'
            );
            insert child1;

            // Update parent status to 'Completed'
            parent.CQ_GJ_Parent_Query__c = 'Completed';
            update parent;

            // Try deleting child - an error is expected as the parent status is 'Completed'
            Database.DeleteResult deleteResult2 = Database.delete(child1, false);
            System.assert(!deleteResult2.isSuccess(), 'Expected exception not thrown for deleting child with parent status as Completed');
        }
    }
}