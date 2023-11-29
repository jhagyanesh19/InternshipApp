trigger CQ_GJ_Parent_Object_Trigger on CQ_GJ_SQX_Parent_Object__c (before update) {

    if(Trigger.isUpdate && trigger.isBefore){
        //calling the method to move the workflow to completed and resticting the user from updtion when the. status is closed
          CQ_GJ_ParentObject_Trigerhandler.handleBeforeUpdate(trigger.new, trigger.oldMap);
   
    }
    
    
}