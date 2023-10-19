trigger CQ_GJ_Child_Object_Trigger on CQ_GJ_SQX_Child_Object__c (before update, before delete) {
    if((Trigger.isUpdate && trigger.isBefore)){
        //calling below method to prevent from uodate when the status is completed or closed
        CQ_GJ_ChildObject_Trigger_Handler.preventer(trigger.new);
    }else  if(Trigger.isDelete && trigger.isBefore){
        //preventing from deletion when the status is moved from draft
        CQ_GJ_ChildObject_Trigger_Handler.handleBeforeDelete(trigger.old);
        
    }
}