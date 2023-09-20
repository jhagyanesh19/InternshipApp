@isTest
public class InternshipApplicationTriggerTest {
    public static void runtheMethods(){
        testApplyWithOpennings_Greater_Than_0_And_New_Staus_Application();
        testApplyWithOpennings_Greater_Than_0_And_Hired_Staus_Application();
        testApplyWithOpennings_Greater_Than_0_And_Rejected_Staus_Application();
        testApplyWithOpennings_Greater_Less_Than_0_And_New_Staus_Application();
        
    }
static Date d = Date.today();


    static Internship__c testInternship = new Internship__c(
    Name = 'TestSoftwareDeveloper',
    Status__c='Opened',
    Opennings__c = 0,
    WorkingArea__c = 'Chorus',
    InternshipLevel__c = 'Hard H1',
    Email__c = 'gyaneshjha4@gmail.com',
    InternshipStartDate__c = d.addDays(10),  
    InternshipApplicationDeadline__c = d.addDays(2),  
    InternshipEndDate__c = d.addDays(30) 
    );
//--------------------------------------------------------------------------------------------------------------------------------------
    static Internship_Application__c hiredApplication = new Internship_Application__c(
            Status__c = 'New',
            CandEmail__c = 'test@example01.com',
            Internship__c = testInternship.Id);
        
static testMethod void testApplyWithOpennings_Greater_Than_0_And_New_Staus_Application() {
    
   
    insert testInternship;
    
       
    hiredApplication.Status__c='Hired';
    try{
        update hiredApplication;
        System.debug('The Intern is Hired --testApplyWithOpennings_Greater_Than_0_And_New_Staus_Application');
    }catch(DmlException e){
        System.debug('Something error in this --testApplyWithOpennings_Greater_Than_0_And_New_Staus_Application');
    }
}
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    static testMethod void testApplyWithOpennings_Greater_Than_0_And_Hired_Staus_Application() {
        
    insert testInternship;
    
        
    hiredApplication.Status__c='Hired';
    try{
        update hiredApplication;
                System.debug('Something error in this --testApplyWithOpennings_Greater_Than_0_And_Hired_Staus_Application');
    }catch(DmlException e){
        System.debug('Sorry, The Interns is already Hired --testApplyWithOpennings_Greater_Than_0_And_Hired_Staus_Application');

    }
}
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     static testMethod void testApplyWithOpennings_Greater_Than_0_And_Rejected_Staus_Application() {
    insert testInternship;
    
       
    hiredApplication.Status__c='Rejected';
    try{
        update hiredApplication;
     System.debug('The Interns is Rejected and opennings are available now fot this position--testApplyWithOpennings_Greater_Than_0_And_Rejected_Staus_Application');
    }catch(DmlException e){
               System.debug('Something error in this --testApplyWithOpennings_Greater_Than_0_And_Rejected_Staus_Application');
    
    }
}
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    static testMethod void testApplyWithOpennings_Greater_Less_Than_0_And_New_Staus_Application() {
    insert testInternship;
        testInternship.Opennings__c=0;
        update testInternship;
    
        
    hiredApplication.Status__c='Hired';
    try{
        update hiredApplication;
        System.debug('Something error in this --testApplyWithOpennings_Greater_Than_0_And_Hired_Staus_Application');
    }catch(DmlException e){

                System.debug('Opennings is closed for this positions --testApplyWithOpennings_Greater_Than_0_And_Hired_Staus_Application');
    }
}
}