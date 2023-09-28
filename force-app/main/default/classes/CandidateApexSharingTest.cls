@isTest
public class CandidateApexSharingTest {

    static testMethod void testCandidateSharing() {
        //selecting the profiles to assign the testUser, and testUser should have the rights of the intern
         User testUser;
      String profileName = 'Intern';
         String query = 'SELECT Id FROM Profile WHERE Name = :profileName LIMIT 1';
         List<Profile> internProfiles = Database.query(query);
         Date d = Date.today();

       {
         
     //creating the testUser  
      testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'gyanesh@mail.com',
            Email = 'gyanesh@mail.com',
            Alias = 'tuser',
            ProfileId = internProfiles[0].id,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US');
        insert testUser;
       
    }
       
        //creating the testCandidate 

        Candidate__c testCandidate = new Candidate__c(
            Email__c = 'John@gmail.com',
            User__c=testUser.id
           );
        insert testCandidate;
      
        //assigning the apexSharing to that candidate
          
        List<Candidate__c> queriedStudents = [SELECT Id,  Email__c FROM Candidate__c WHERE User__c = :testUser.id LIMIT 1];
        System.debug(queriedStudents);

        Candidate__Share candidateShare = new Candidate__Share();
        candidateShare.ParentId = testCandidate.Id;
        candidateShare.UserOrGroupId = testUser.Id; 
        candidateShare.AccessLevel = 'read'; 
        candidateShare.RowCause = Schema.Candidate__Share.RowCause.user__c;

       
        //checking for the apexSharing

        
        List<Candidate__Share> candidateShares = [
            SELECT Id, ParentId, UserOrGroupId, AccessLevel, RowCause
            FROM Candidate__Share
            WHERE ParentId = :testCandidate.Id And UserOrGroupId=:testUser.id
        ];

        
        System.assertEquals(1, candidateShares.size());
        System.assertEquals(testUser.Id, candidateShares[0].UserOrGroupId);
        System.assertEquals('Read', candidateShares[0].AccessLevel);
        System.assertEquals(Schema.Candidate__Share.RowCause.user__c, candidateShares[0].RowCause);

    }
}