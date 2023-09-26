trigger InternshipApplicationTriggerHandler on Internship_Application__c (after insert, after update, before delete ) {
if( Trigger.isAfter && Trigger.isInsert ){
    //fire when the type of trigger isInsert and isAfter
            InternshipApplicationTriggerContainer.newInternshipAlert(Trigger.new);
        }else if (Trigger.isAfter && Trigger.isUpdate) {
             //fire when the type of trigger isUpdate and isAfter
            InternshipApplicationTriggerContainer.internshipApplicationStatusUpdater(Trigger.new, Trigger.oldMap);
        }else if(Trigger.isBefore && Trigger.isDelete){
               //fire when the type of trigger isBefore and isDelete
            InternshipApplicationTriggerContainer.preventDeleteInternship(Trigger.old);
        }
}