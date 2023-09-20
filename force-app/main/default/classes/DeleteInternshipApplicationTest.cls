@isTest
public class DeleteInternshipApplicationTest {

    static testMethod void testDeleteWithHiredStatus() {
       
       Date d = Date.today();


Internship__c testInternship = new Internship__c(
    Name = 'TestSoftwareDeveloper',
    Status__c='Opened',
    Opennings__c = 9,
    WorkingArea__c = 'Chorus',
    InternshipLevel__c = 'Hard H1',
    Email__c = 'gyaneshjha4@gmail.com',
    InternshipStartDate__c = d.addDays(10),  
    InternshipApplicationDeadline__c = d.addDays(2),  
    InternshipEndDate__c = d.addDays(30) 
);
insert testInternship;


        // Create a test Internship_Application__c record related to the test Internship with "Hired" status
        Internship_Application__c hiredApplication = new Internship_Application__c(
            Status__c = 'Hired',
            CandEmail__c = 'test@example.com',
            Internship__c = testInternship.Id
        );
        insert hiredApplication;

        Test.startTest();
        try {
            
            delete hiredApplication;

           System.Debug('Deletion should have been allowed for this record.');
           

        } catch (DmlException e) {
             System.Debug('Sorry, Deleting Hired Internship Application at this stage is not Allowed.');
        }
        Test.stopTest();
    }

  

    
       
    }