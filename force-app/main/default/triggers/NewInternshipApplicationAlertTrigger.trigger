trigger NewInternshipApplicationAlertTrigger on Internship_Application__c (after insert) {
       List<Messaging.Email> emailList = new List<Messaging.Email>(); 
    Id loggedInUserId = UserInfo.getUserId();
    
    for (Internship_Application__c app : Trigger.new) {
List<Internship_Application__c> internshipApps = [SELECT Id,CandEmail__c, Name,Internship__r.Status__c,Candidate__r.Name, Internship__r.Email__c,Internship__r.Name  FROM Internship_Application__c where id=:app.id];        
       
   String ownerEmails=null;
        String name=null;
        Id internshipId=null;
        String Status=null;
        String CandName=null;
        String CandEmail=null;
        for(Internship_Application__c a :internshipApps){
             ownerEmails=a.Internship__r.Email__c;
            name=a.Internship__r.name;
            internshipId=a.Internship__r.id;
            Status=a.Internship__r.Status__c;
            CandName=a.Candidate__r.Name;
            candEmail=a.CandEmail__c;
            
        }
List<Internship_Application__c> aggregateResults = [SELECT Name FROM Internship_Application__c WHERE Internship__r.Id = :internshipId AND CandEmail__c = :candEmail];


        

        if (ownerEmails!=null && aggregateResults.size()==1 && Status=='Opened') {
           
   
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
           
          email.setTemplateId('00X5j000000hi7y');
          
            
            
            email.setReplyTo(ownerEmails);
         
            email.setWhatId(app.Id);
     
            email.setToAddresses(new String[] { ownerEmails });
          
            
           
            email.setSubject('New Internship Application Found');
            email.setPlainTextBody('I hope this message finds you well. We are excited to inform you that a new internship application has been submitted for the '+name+' position.');
            
            emailList.add(email);
           
        }
        else{
            if(aggregateResults.size()!=1){
                app.addError('You have been alredy applied for "'+name+'" position');
            }else if(Status!='Opened'){
                app.addError('The Hiring for this position is now "Closed"');
            }
    }
    }
    
    // Send the email messages
 //Messaging.sendEmail(emailList);
}