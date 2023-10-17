public class CQ_GJ_ParentObject_Trigerhandler {
    
 
    public static void handleBeforeUpdate(List<CQ_GJ_SQX_Parent_Object__c> newParents, Map<Id, CQ_GJ_SQX_Parent_Object__c> oldParentsMap){
        List<CQ_GJ_SQX_Child_Object__c> parentsToUpdate = new List<CQ_GJ_SQX_Child_Object__c>();
       Set<Id> parentIds = new Set<Id>();
        Map<Id, CQ_GJ_SQX_Child_Object__c> parentToChildMap = new Map<Id, CQ_GJ_SQX_Child_Object__c>();
        
        for (CQ_GJ_SQX_Parent_Object__c parent : newParents) {
            parentIds.add(parent.Id);
            parentToChildMap.put(parent.Id, null);
        }
        
        // Query parent status for all child records outside of the loop
        for (CQ_GJ_SQX_Child_Object__c child : [SELECT Id, CQ_GJ_SQX_Parent_Info__r.CQ_GJ_Parent_Query__c  
                                               FROM CQ_GJ_SQX_Child_Object__c 
                                               WHERE CQ_GJ_SQX_Parent_Info__c IN :parentIds
                                               AND CQ_GJ_Upload_Marksheet__c != null limit 1]) {
            parentToChildMap.put(child.CQ_GJ_SQX_Parent_Info__c, child);
        }

        for (Id parentId : parentToChildMap.keySet()) {
            System.debug('Parent Id is ' + parentId+'-----'+parentToChildMap.get(parentId));
            
        }        
        for (CQ_GJ_SQX_Parent_Object__c parent : newParents) {
            //get the value ofold parent
            CQ_GJ_SQX_Parent_Object__c oldParent = oldParentsMap.get(parent.Id);
           
            if (oldParent.CQ_GJ_Parent_Query__c == 'In progress') {
                
                    //query for getting the child with attachment
             CQ_GJ_SQX_Child_Object__c resultList = parentToChildMap.get(parent.Id);
                    
                    //if this parent contains any child with attachment then the status will move to be completed
                    if(resultList!=null){
                    resultList.CQ_GJ_SQX_Parent_Info__r.CQ_GJ_Parent_Query__c='Completed';
                     parentsToUpdate.add(resultList);
                    }else{
                       parent.CQ_GJ_Parent_Query__c.addError('Sorry, either it does not have any associated child or there is no attachment related to ' + parent.Name);
                    
                    }
                
            }
            
         else if (oldParent.CQ_GJ_Parent_Query__c == 'Closed') {
            //if the status is closed than restricting the upadtion
                parent.CQ_GJ_Parent_Query__c.addError('Updation at this stage is not allowed.');
        }else if(oldParent.CQ_GJ_Parent_Query__c == 'Completed' && (parent.CQ_GJ_Parent_Query__c == 'Draft' || parent.CQ_GJ_Parent_Query__c == 'In Progress')){
            //restricting form moving to backward status
            parent.CQ_GJ_Parent_Query__c.addError('Sorry, Now you can update the status only to be Completed & You can not go backward stage'); 
        }else if (oldParent.CQ_GJ_Parent_Query__c == 'In Progress' && parent.CQ_GJ_Parent_Query__c == 'Draft'){
              //restricting form moving to backward status
              parent.CQ_GJ_Parent_Query__c.addError('Sorry, Now you can update the status only to be Completed / closed & You can not go backward stage'); 
        }
            }
        
            
        if(parentsToUpdate!=null){
            //updating the parent
            update parentsToUpdate;
        }
        
    }
    
    

}