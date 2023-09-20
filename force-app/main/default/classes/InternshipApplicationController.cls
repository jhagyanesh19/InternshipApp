// InternshipApplicationController.cls
public with sharing class InternshipApplicationController {
    @AuraEnabled(cacheable=true)
    public static List<Internship_Application__c> getInternshipOpportunities() {
        return [SELECT Id, Name FROM Internship_Application__c];
    }
}