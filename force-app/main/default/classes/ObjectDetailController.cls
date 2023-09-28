public with sharing class ObjectDetailController {
    @AuraEnabled(cacheable=true)
    public static List<Internship_Application__c> getObjectDetails() {
        //here iam fetching only that internship_Application that is assoscialted with the current loggediIn user
        //so that the current loggedIn wont be able to someone else's application and should be able to view his only applications
        Id loggedInUserId = UserInfo.getUserId();
List<Internship_Application__c> internshipApplications = [SELECT Id, Status__c, Internship__r.Name FROM Internship_Application__c WHERE Internship__r.Name!=NULL AND  OwnerId = :loggedInUserId];
return internshipApplications;
      
    }
}