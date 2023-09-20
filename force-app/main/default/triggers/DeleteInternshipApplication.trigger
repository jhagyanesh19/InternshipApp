trigger DeleteInternshipApplication on Internship_Application__c (before delete) {
 for (Internship_Application__c app : Trigger.old) {
     if(app.Status__c=='Hired'){
         
            app.addError('Sorry, Deleting Internship Application at this stage is not Allowed.');
           
     }
}
}