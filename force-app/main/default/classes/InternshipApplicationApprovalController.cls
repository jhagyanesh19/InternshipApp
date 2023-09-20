public with sharing class InternshipApplicationApprovalController {
    
    /**
     * @description approveRequest
     */
    @AuraEnabled
    public static String approveRejectRequest(String recordIdStr, String isApprove){
        try{
 
            String resultString = (isApprove=='Hired') ? 'Hired': 'Rejected';
            Internship_Application__c sta=New Internship_Application__c();
            sta.id=recordIdStr;
            sta.Status__c=resultString;
          
            update sta;
          
       
          
                return resultString;
           
        }
        catch(Exception e){ throw new AuraHandledException(e.getMessage()); }
    }
}