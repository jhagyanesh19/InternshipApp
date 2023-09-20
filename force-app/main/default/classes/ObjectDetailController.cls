public with sharing class ObjectDetailController {
    @AuraEnabled(cacheable=true)
    public static List<Internship_Application__c> getObjectDetails() {
        
        Id loggedInUserId = UserInfo.getUserId();
List<Internship_Application__c> internshipApplications = [SELECT Id, Status__c, Internship__r.Name FROM Internship_Application__c WHERE Internship__r.Name!=NULL AND  OwnerId = :loggedInUserId];
return internshipApplications;
      
    }
}