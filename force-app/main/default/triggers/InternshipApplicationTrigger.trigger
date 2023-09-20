trigger InternshipApplicationTrigger on Internship_Application__c (after update) {
    List<Messaging.Email> emailList = new List<Messaging.Email>(); 
    
    
    for (Internship_Application__c app : Trigger.new) {
         Internship_Application__c oldApp = Trigger.oldMap.get(app.Id);
        
       
        if (app.Status__c == 'Hired' && oldApp.Status__c!='Hired') {
            Internship_Application__c internshipApps = [SELECT Id, Name, Internship__r.Opennings__c, Internship__r.Email__c  FROM Internship_Application__c where id=:app.id LIMIT 1];  
           
            if(internshipApps.Internship__r.Opennings__c>0){
            internshipApps.Internship__r.Opennings__c-=1;
           update internshipApps.Internship__r;
           
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            
          
          email.setTemplateId('00X5j000000hi7y');
          
            
            email.setReplyTo('gyaneshjha4@gmail.com');
      
            email.setWhatId(app.Id);
          
            email.setToAddresses(new String[] { app.candEmail__c });
            
       
            email.setSubject('Internship Application Selected');
            email.setPlainTextBody('Congratulations!!! I am pleased to inform you that your application for been selected.We were impressed with your qualifications, enthusiasm, and the potential you demonstrated. We believe that you will be a valuable addition to our team, and we look forward to welcoming you to our organization.');
            
         
                emailList.add(email);
            }
            
            else{
                    app.addError('Opennings is full for this Internship');
                }
          
        }
        else if(oldApp.Status__c=='Hired' && app.Status__c=='Rejected'){
              Internship_Application__c internshipApps = [SELECT Id, Name, Internship__r.Opennings__c, Internship__r.Email__c  FROM Internship_Application__c where id=:app.id LIMIT 1];  
              internshipApps.Internship__r.Opennings__c+=1;
           update internshipApps.Internship__r;
            
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
         
          email.setTemplateId('00X5j000000hi7y');
          
                        
            email.setTargetObjectId(app.Id); 
            email.setWhatId(app.Id);
            email.setToAddresses(new String[] { app.candEmail__c });
            email.setSubject('Internship Application Rejected');
             email.setPlainTextBody('Thank you for applying, We could not process your application further. Try applying next time');
            
           
            emailList.add(email);
        }
        else if(app.Status__c == 'Rejected'){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
         
          email.setTemplateId('00X5j000000hi7y');
          
                        
            email.setTargetObjectId(app.Id); 
            email.setWhatId(app.Id);
            email.setToAddresses(new String[] { app.candEmail__c });
            email.setSubject('Internship Application Rejected');
             email.setPlainTextBody('Thank you for applying, We could not process your application further. Try applying next time');
            
           
            emailList.add(email);
        }
    }
    
  
//Messaging.sendEmail(emailList);
}