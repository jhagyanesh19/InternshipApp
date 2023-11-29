public class CQ_GJ_ChildObject_Trigger_Handler {
    public static void preventer(List<CQ_GJ_SQX_Child_Object__c> childList){
        Set<Id> childIds = new Set<Id>();
        
   // Query parent status for all child records outside of the loop
        Map<Id, CQ_GJ_SQX_Child_Object__c> childStatusMap = new Map<Id, CQ_GJ_SQX_Child_Object__c>(
            [SELECT Id, CQ_GJ_SQX_Parent_Info__r.CQ_GJ_Parent_Query__c, CQ_GJ_SQX_Parent_Info__r.Name 
            FROM CQ_GJ_SQX_Child_Object__c 
            WHERE Id IN :childIds]
        );
        
        // Check parent status and add error messages inside the loop
        for (CQ_GJ_SQX_Child_Object__c child : childList) {
            CQ_GJ_SQX_Child_Object__c fetchParentStatus = childStatusMap.get(child.Id);
            System.debug(child.CQ_GJ_SQX_Parent_Info__c+'iam new parent');
            System.debug(fetchParentStatus.CQ_GJ_SQX_Parent_Info__c+'iam old parent');
            //preventing from parent's  updation
             if((child.CQ_GJ_SQX_Parent_Info__c==fetchParentStatus.CQ_GJ_SQX_Parent_Info__c)){
            
            //checking for the condition when not allowing to update
            
            if (fetchParentStatus != null && 
                (fetchParentStatus.CQ_GJ_SQX_Parent_Info__r.CQ_GJ_Parent_Query__c == 'Completed' || 
                 fetchParentStatus.CQ_GJ_SQX_Parent_Info__r.CQ_GJ_Parent_Query__c == 'Closed')) {
                //throwing error
                child.addError(System.Label.CQ_GJ_Updation_Error);
            }
                }else{
               child.addError(System.Label.CQ_GJ_Change_Parent_Error);

                }
        }
    }
    
        public static void handleBeforeDelete(List<CQ_GJ_SQX_Child_Object__c> childList) {
            for (CQ_GJ_SQX_Child_Object__c child : childList) {
                //if status is not eaquals to draft then are preventing from deletion
                  if (child.CQ_GJ_SQX_Parent_Info__r.CQ_GJ_Parent_Query__c != 'Draft') {
                child.addError(System.Label.CQ_GJ_Deleteion_Error);
            }
        }
   
}
        }