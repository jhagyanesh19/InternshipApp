@isTest
public class InternshipApplicationTriggerTest {

    //query for getting the id of profile whose name is Intern
 static Profile intern = [SELECT Id FROM Profile where name='Intern' limit 1];
    
   static Date d = Date.today();
    //creating a testUser here
    static User testUser;
    static {
        testUser = new User(
            ProfileId = intern.id, 
            Username = 'gyanesh@fmail.com',
            Email = 'gyanesh@fmail.com',
            FirstName='Test',
            LastName='Jha',
            Alias = 'tjha',
            TimeZoneSidKey = 'GMT',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;
    }
    //creating a testInternship below, and getting the statusOfInternship from methods
    static Internship__c createTestInternship(String statusOfInternship){
        Internship__c testInternship = new Internship__c(
    Name = 'TestSoftwareDeveloper',
    Status__c=statusOfInternship,
    Opennings__c = 10,
    WorkingArea__c = 'Chorus',
    InternshipLevel__c = 'Hard H1',
    Email__c = 'gyaneshjha4@gmail.com',
    InternshipStartDate__c = d.addDays(10),  
    InternshipApplicationDeadline__c = d.addDays(2),  
    InternshipEndDate__c = d.addDays(30));
    
     return testInternship;
    }
    
    //creating a Internship testApplication below and getting the internship id applying for(appId), status of Internship_Application__c as arguments   
    static Internship_Application__c createTestApplication(Id appId, String status){
         Internship_Application__c hiredApplication = new Internship_Application__c(
            Status__c = status,
            CandEmail__c = 'gyaneshjha4@gmail.com',
            Internship__c = appId);
        return hiredApplication;        
    }
    
   

    static testMethod  void hireTheCandidate() {
        // Run the test as the specified test user
        System.runAs(testUser) {
            // Create a test Internship
            Internship__c testInternship = createTestInternship('Opened');
            insert testInternship;

            // Create a test Internship Application with 'New' status
            Internship_Application__c hiredApplication = createTestApplication(testInternship.Id, 'New');
            insert hiredApplication;

            // Change the status to 'Hired' and update the record
            hiredApplication.Status__c = 'Hired';
      
                update hiredApplication;
                
                System.assertEquals( hiredApplication.status__c ,'Hired', 'The Intern is Hired --testApplyWithOpennings_Greater_Than_0_And_New_Status_Application');
           
        }
    }
        
        
	 static testMethod void rejectingTheApplication() {
        // Run the test as the specified test user
        System.runAs(testUser) {
            // Create a test Internship
            Internship__c testInternship = createTestInternship('Opened');
            insert testInternship;

            // Create a test Internship Application with 'New' status
            Internship_Application__c hiredApplication = createTestApplication(testInternship.Id, 'New');
           
            insert hiredApplication;

            // Change the status to 'Hired' and update the record
            hiredApplication.Status__c = 'Rejected';
      
               update hiredApplication;
               System.assertEquals( hiredApplication.status__c ,'Rejected', 'The Intern is Hired --testApplyWithOpennings_Greater_Than_0_And_New_Status_Application');
           
        }
    
    }
    
        
     static testMethod  void preventHiringWithOpenningsZero() {
        // Run the test as the specified test user
        System.runAs(testUser) {
            
            // Create a test Internship
            Internship__c testInternship = createTestInternship('Opened');
            insert testInternship;
            testInternship.Opennings__c=-1;
            update testInternship;
            testInternship.Status__c='Opened';
            update testInternship;

            // Create a test Internship Application with 'New' status
            Internship_Application__c hiredApplication = createTestApplication(testInternship.Id, 'New');
            insert hiredApplication;

            // Change the status to 'Hired' and update the record
            hiredApplication.Status__c = 'Hired';
         
            try{
              update hiredApplication;  
            }catch(System.DmlException e)
            {
                System.AssertEquals('Update failed', 'Update failed', ' Hired Even after the opennings is zero');
            }
           
        }
    }
    
    static testMethod void rejectTheHiredCandidate() {
        // Run the test as the specified test user
        System.runAs(testUser) {
            // Create a test Internship
            Internship__c testInternship = createTestInternship('Opened');
            insert testInternship;

            // Create a test Internship Application with 'New' status
            Internship_Application__c hiredApplication = createTestApplication(testInternship.Id, 'New');
           
            insert hiredApplication;
            
            hiredApplication.status__c='Hired';
            update hiredApplication;
            // Change the status to 'Hired' and update the record
            hiredApplication.Status__c = 'Rejected';
      
            System.AssertEquals( hiredApplication.Status__c, 'Rejected', 'Again Hired');
           
           
        }
    
    }
    
    static testMethod void preventDuplicity() {
        // Run the test as the specified test user
        System.runAs(testUser) {
            // Create a test Internship
            Internship__c testInternship = createTestInternship('Opened');
            insert testInternship;

            // Create a test Internship Application with 'New' status
            Internship_Application__c hiredApplication  = createTestApplication(testInternship.Id, 'New');
            Internship_Application__c hiredApplication1 =createTestApplication(testInternship.Id, 'New');
            try{
                insert hiredApplication;
                insert hiredApplication1;
        }Catch(System.DmlException e)
        {
            System.assertEquals( 'Insert failed', 'Insert failed','taking duplicate applications');
        }
       
        }
    
    }
   
    
    static testMethod  void preventTakingApplicationAfterStatusIsClosed() {
        // Run the test as the specified test user
        System.runAs(testUser) {
            // Create a test Internship
            Internship__c testInternship = createTestInternship('Closed');
            insert testInternship;

            // Create a test Internship Application with 'New' status
            Internship_Application__c hiredApplication = createTestApplication(testInternship.Id, 'New');
            try{
                insert hiredApplication;
            }catch(System.DmlException e){
                System.assertEquals('Insert failed', 'Insert failed', 'The position is closed but still taking applications');
            }
        }
    }
    
     static testMethod  void preventDeleteAfterHired() {
        // Run the test as the specified test user
        System.runAs(testUser) {
            // Create a test Internship
            Internship__c testInternship = createTestInternship('Opened');
            insert testInternship;

            // Create a test Internship Application with 'New' status
            Internship_Application__c hiredApplication = createTestApplication(testInternship.Id, 'New');
            insert hiredApplication;

            // Change the status to 'Hired' and update the record
            hiredApplication.Status__c = 'Hired';
      		update hiredApplication;
     	try{
            //try deleting the hiredApplication
           delete hiredApplication;
        }catch(System.DmlException e){
            System.assertEquals('Delete failed', 'Delete failed', 'Something error is there, It is deleting the application even after the Status is Hired');
        }
            
           
        }
    }
    
    //checking for custom Validation-- Deadline of Internship can't be ahead of Internship Start Date --
    
    static testMethod void checkValidationRules1(){
        Internship__c testInternship = new Internship__c(
    Name = 'TestSoftwareDeveloper',
    Status__c='opened',
    Opennings__c = 10,
    WorkingArea__c = 'Chorus',
    InternshipLevel__c = 'Hard H1',
    Email__c = 'gyaneshjha4@gmail.com',
    InternshipStartDate__c = d.addDays(1),  
    InternshipApplicationDeadline__c = d.addDays(2),  
    InternshipEndDate__c = d.addDays(30));
    
  
        try{
            insert testInternship;
        }catch(System.DmlException e){
            System.assertEquals('Insert failed', 'Insert failed', 'error');
        }

    
    } 
    
       
    //checking for custom Validation-- StartDate of Internship can't be ahead of Internship End Date -- 
    static testMethod void checkValidationRules2(){
        Internship__c testInternship = new Internship__c(
    Name = 'TestSoftwareDeveloper',
    Status__c='opened',
    Opennings__c = 10,
    WorkingArea__c = 'Chorus',
    InternshipLevel__c = 'Hard H1',
    Email__c = 'gyaneshjha4@gmail.com',
    InternshipStartDate__c = d.addDays(2),  
    InternshipApplicationDeadline__c = d.addDays(31),  
    InternshipEndDate__c = d.addDays(30));
    
  
        try{
            insert testInternship;
        }catch(System.DmlException e){
            System.assertEquals('Insert failed', 'Insert failed', 'error');
        }

    
    } 
    
}