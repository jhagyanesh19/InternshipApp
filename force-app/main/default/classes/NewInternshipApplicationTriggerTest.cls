@isTest
public class NewInternshipApplicationTriggerTest {
   
      static Date d = Date.today();


static Internship__c testInternship = new Internship__c(
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
//--------------------------------------------------------------------------------------------------------------------------------------

static testMethod void testApplyWithDuplicity() {
    insert testInternship;
    
        Internship_Application__c hiredApplication = new Internship_Application__c(
            Status__c = 'New',
            CandEmail__c = 'test@example01.com',
            Internship__c = testInternship.Id
           );
  
     
       
       Internship_Application__c hiredApplication1 = new Internship_Application__c(
            Status__c = 'New',
            CandEmail__c = 'test@example01.com',
            Internship__c = testInternship.Id
          );
        String numb1=hiredApplication1.Name;

        Test.startTest();
    try {
           insert hiredApplication;
          insert hiredApplication1;
        System.debug('New Application Created');
        
    }catch (DmlException e) {
             System.Debug('Sorry, You have already applied for this position from with');
        }
      Test.stopTest();
}
    
//------------------------------------------------------------------------------------------------------------------------------------
    static testMethod void testApplyWithUniqueApplications() {
    insert testInternship;
    
        Internship_Application__c hiredApplication3 = new Internship_Application__c(
            Status__c = 'New',
            CandEmail__c = 'test@examples.com',
            Internship__c = testInternship.Id
           );
     
       
      
      

        Test.startTest();
       
    try {
        
           insert hiredApplication3;
        
        System.debug('New Application(s) Created from without');
        
    }catch (DmlException e) {
             System.Debug('Sorry, You have already applied for this position from without');
    }
        Test.stopTest();
}
    
    //---------------------------------------------------------------------------------------------------------------------------
    
    static testMethod void testApplyWithStatusOpened() {
        
           insert testInternship;
          Internship_Application__c hiredApplication = new Internship_Application__c(
            Status__c = 'New',
            CandEmail__c = 'test@smething.com',
            Internship__c = testInternship.Id
          );
         Test.startTest();
      //---------------------------
         if(testInternship.Status__c=='Opened'){
           
    try {
      
       insert hiredApplication;
        System.debug('New Application(s) Created from opened');
        
    }
             catch (DmlException e) {
             System.Debug('There is something error in this app');
    }
         }else{
             System.debug('Sorry, something went wrong');
         }
          Test.stopTest();
        
       
    }
    //--------------------------------------------------------------------------------------------------------------
       static testMethod void testApplyWithStatusClosed() {
           insert testInternship;
           testInternship.Status__c='Closed';
           update testInternship;
          Internship_Application__c hiredApplication = new Internship_Application__c(
            Status__c = 'New',
            CandEmail__c = 'test@smething.com',
            Internship__c = testInternship.Id
          );
            Test.startTest();
      //---------------------------
         if(testInternship.Status__c=='Closed'){
        try {
       insert hiredApplication;
        System.debug('There is something error in code ');
        
    }
             catch (DmlException e) {
              System.Debug('Sorry, The Hiring for this position is now closed from closed');
    }
           
    }else{
             System.debug('Sorry, something went wrong');
         }
             Test.stopTest();
        
       
    }
}