// InternshipApplicationController.cls
public with sharing class InternshipApplicationController {
    @AuraEnabled(cacheable=true)
    //getting all of the internship to show to USers
    public static List<Internship_Application__c> getInternshipOpportunities() {
        return [SELECT Id, Name FROM Internship_Application__c];
    }
}