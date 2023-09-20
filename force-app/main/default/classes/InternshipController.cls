public class InternshipController {
    @AuraEnabled
    public static List<Internship__c> getInterships() {
        // Query data from the Internship__c object
        List<Internship__c> internships = [SELECT Id, Name, InternshipStartDate__c, InternshipEndDate__c FROM Internship__c where InternshipStartDate__c!=null AND InternshipEndDate__c!=null];
      //iam commiting these
return internships;
    }
}