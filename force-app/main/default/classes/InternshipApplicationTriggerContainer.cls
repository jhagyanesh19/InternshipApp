public class InternshipApplicationTriggerContainer {

    // This method sends an email alert for new internship applications
    public static void newInternshipAlert(List<Internship_Application__c> appList) {
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        Id loggedInUserId = UserInfo.getUserId();

        for (Internship_Application__c app : appList) {
            // Query related internship application records
            List<Internship_Application__c> internshipApps = [SELECT Id, CandEmail__c, Name, Internship__r.Status__c, Candidate__r.Name, Internship__r.Email__c, Internship__r.Name FROM Internship_Application__c WHERE Id = :app.Id];

            String ownerEmails = null;
            String name = null;
            Id internshipId = null;
            String Status = null;
            String CandName = null;
            String candEmail = null;

            // Extract data from related records
            for (Internship_Application__c a : internshipApps) {
                ownerEmails = a.Internship__r.Email__c;
                name = a.Internship__r.Name;
                internshipId = a.Internship__r.Id;
                Status = a.Internship__r.Status__c;
                CandName = a.Candidate__r.Name;
                candEmail = a.CandEmail__c;
            }

            // Query to check for existing applications and status
            List<Internship_Application__c> aggregateResults = [SELECT Name FROM Internship_Application__c WHERE Internship__r.Id = :internshipId AND CandEmail__c = :candEmail];

            // Check conditions and send an email if necessary
            if (ownerEmails != null && aggregateResults.size() == 1 && Status == 'Opened') {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setReplyTo(ownerEmails);
                email.setWhatId(app.Id);
                email.setToAddresses(new String[] { ownerEmails });
                email.setSubject('New Internship Application Found');
                email.setPlainTextBody('I hope this message finds you well. We are excited to inform you that a new internship application has been submitted for the ' + name + ' position.');
                emailList.add(email);
            } else {
                //check for duplicity
                if (aggregateResults.size() != 1) {
                    app.addError('You have already applied for the "' + name + '" position');
                } else if (Status != 'Opened') {
                    //checks if the status of openningStatus is closed, then stop hiring
                    app.addError('The hiring for this position is now "Closed"');
                }
            }
        }

        // Send the email messages (commented out)
        // Messaging.sendEmail(emailList);
    }

    // This method updates internship application statuses and sends emails accordingly
    public static void internshipApplicationStatusUpdater(List<Internship_Application__c> newList, Map<Id, Internship_Application__c> oldMaps) {
        List<Messaging.Email> emailList = new List<Messaging.Email>();

        for (Internship_Application__c app : newList) {
            Internship_Application__c oldApp = oldMaps.get(app.Id);

            if (app.Status__c == 'Hired' && oldApp.Status__c != 'Hired') {
                // Update the internship openings and send a "selected" email
                Internship_Application__c internshipApps = [SELECT Id, Name, Internship__r.Opennings__c, Internship__r.Email__c FROM Internship_Application__c WHERE Id = :app.Id LIMIT 1];
                if (internshipApps.Internship__r.Opennings__c > 0) {
                    internshipApps.Internship__r.Opennings__c -= 1;
                    update internshipApps.Internship__r;
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setReplyTo(internshipApps.Internship__r.Email__c);
                    email.setWhatId(app.Id);
                    email.setToAddresses(new String[] { app.CandEmail__c });
                    email.setSubject('Internship Application Selected');
                    email.setPlainTextBody('Congratulations! We are pleased to inform you that your application for the ' + internshipApps.Name + ' position has been selected. We look forward to welcoming you to our organization.');
                    emailList.add(email);
                } else {
                    //if the related openning for any app is zero then 
                    app.addError('Openings are full for this internship');
                }
            } else if (oldApp.Status__c == 'Hired' && app.Status__c == 'Rejected') {
                // Update internship openings and send a "rejected" email
                Internship_Application__c internshipApps = [SELECT Id, Name, Internship__r.Opennings__c, Internship__r.Email__c FROM Internship_Application__c WHERE Id = :app.Id LIMIT 1];
                internshipApps.Internship__r.Opennings__c += 1;
                update internshipApps.Internship__r;
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setTargetObjectId(app.Id);
                email.setWhatId(app.Id);
                email.setToAddresses(new String[] { app.CandEmail__c });
                email.setSubject('Internship Application Rejected');
                email.setPlainTextBody('Thank you for applying. We could not process your application further. Please consider applying again in the future.');
                emailList.add(email);
            } else if (app.Status__c == 'Rejected') {
                // Send a "rejected" email
                Internship_Application__c internshipApps = [SELECT Id, Name, Internship__r.Email__c FROM Internship_Application__c WHERE Id = :app.Id LIMIT 1];
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setReplyTo(internshipApps.Internship__r.Email__c);
                email.setWhatId(app.Id);
                email.setToAddresses(new String[] { app.CandEmail__c });
                email.setSubject('Internship Application Rejected');
                email.setPlainTextBody('Thank you for applying. We could not process your application further. Please consider applying again in the future.');
                emailList.add(email);
            }
        }

        // Send the email messages (commented out)
        // Messaging.sendEmail(emailList);
    }

    // This method prevents the deletion of internship applications with a "Hired" status
    public static void preventDeleteInternship(List<Internship_Application__c> oldList) {
        for (Internship_Application__c app : oldList) {
            if (app.Status__c == 'Hired') {
                app.addError('Sorry, deleting this internship application is not allowed at this stage.');
            }
        }
    }
}