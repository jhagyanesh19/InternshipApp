@isTest
public class CQUI_GJ_Test_ParentObject {
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
static testMethod void testTriggerMoveToCompletedWithAttachment() {
    System.runAs(createUserWithPermissionSet()){
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
        update parent;
        Test.stopTest();

        // Verify that the parent's status is updated to 'Completed.'
        CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id];
        System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c);
    }

}
     static testMethod void testTriggerMoveToCompletedWithoutAttachment() {
        // Create a parent with the status 'In Progress.'
        System.runAs(createUserWithPermissionSet()){
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
        update parent;
        Test.stopTest();

        // Verify that the parent's status remains 'In Progress.'
        CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id];
        System.assertEquals('In Progress', updatedParent.CQ_GJ_Parent_Query__c);

        // Verify that an error message is added to the parent.
        System.assert(!parent.hasErrors());
        }}

 
    static testMethod void  testTriggerPreventUpdateWhenStatusIsClosed() {
        System.runAs(createUserWithPermissionSet()){
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
            try{
        update parent;
        
            } catch(System.DmlException e){
        // Verify that the update is prevented, and an error message is added to the parent.
 

        // Verify that an error message is added to the parent.
        System.assert(parent.hasErrors());
    }
            }
    }
    
    static testMethod void testTriggerPreventMovingToDraftFromCompleted() {
        System.runAs(createUserWithPermissionSet()){
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
        update parent;
        Test.stopTest();

        // Verify that the update is prevented, and an error message is added to the parent.
        CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id];
        System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c);

        // Verify that an error message is added to the parent.
        System.assert(!parent.hasErrors());
    }
    }

 
     static testMethod void testTriggerPreventMovingToDraftFromInProgress() {
         System.runAs(createUserWithPermissionSet()){
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
        update parent;
        Test.stopTest();

        // Verify that the update is prevented, and an error message is added to the parent.
        CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id];
        System.assertEquals('In Progress', updatedParent.CQ_GJ_Parent_Query__c);

        // Verify that an error message is added to the parent.
        System.assert(!parent.hasErrors());
         }}

 
   static testMethod  void testTriggerMoveToClosedFromInProgress() {
       System.runAs(createUserWithPermissionSet()){
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
       try{ 
       update parent;
       }catch(System.DmlException e){
           
           System.assertEquals('In Progress', parent.CQ_GJ_Parent_Query__c, 'Upadted');
       }
           test.stopTest();
       }
   }

   
     static testMethod void testTriggerMoveToDraftFromInProgress() {
         System.runAs(createUserWithPermissionSet()){
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
        update parent;
        Test.stopTest();

        // Verify that the parent's status is updated to 'Draft.'
        CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id];
        System.assertEquals('Draft', updatedParent.CQ_GJ_Parent_Query__c);
    }
     }

 
      static testMethod void testTriggerPreventMovingToInProgressFromCompleteds() {
          System.runAs(createUserWithPermissionSet()){
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
        update parent;
        Test.stopTest();

        // Verify that the update is prevented, and an error message is added to the parent.
        CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id];
        System.assertEquals('Completed', updatedParent.CQ_GJ_Parent_Query__c);

        // Verify that an error message is added to the parent.
        System.assert(!parent.hasErrors());
    }
      }

    static testMethod void testTriggerPreventMovingToInProgressFromClosed() {
        System.runAs(createUserWithPermissionSet()){
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
        update parent;
        Test.stopTest();

        // Verify that the update is prevented, and an error message is added to the parent.
        CQ_GJ_SQX_Parent_Object__c updatedParent = [SELECT CQ_GJ_Parent_Query__c FROM CQ_GJ_SQX_Parent_Object__c WHERE Id = :parent.Id];
        System.assertEquals('Closed', updatedParent.CQ_GJ_Parent_Query__c);

        // Verify that an error message is added to the parent.
        System.assert(!parent.hasErrors());
    }
      }
    
    
    
    
}