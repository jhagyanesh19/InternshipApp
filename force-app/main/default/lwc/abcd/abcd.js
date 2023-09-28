import { LightningElement,api, wire } from 'lwc';
 
import Internship_Application__c from '@salesforce/schema/Internship_Application__c';
import { RefreshEvent } from 'lightning/refresh';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
export default class abcd extends LightningElement {
   

    @api recordId;
    status='';

  

    handleApprove(){

       this.status='Hired';

        this.template.querySelector('[data-status]').value =this.status;
        this.template.querySelector('lightning-record-edit-form').submit() ;
    }

 

    handleReject(){
      this.status = 'Rejected';
      this.template.querySelector('[data-status]').value =this.status;
        this.template.querySelector('lightning-record-edit-form').submit() ;
        this.dispatchEvent(new RefreshEvent());
    }

    sendRequest(){
       
                if(this.status == 'Hired'){
                   
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "HIRED !!! ",
                            message: 'This Intern has been Selected!',
                            variant: "success"
                        })
                    );
                 
                    
                }
               
                else if(this.status =='Rejected'){
                    
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "REJECTED !!! ",
                            message: 'This Intern has been Rejected!',
                            variant: "error"
                        })
                    );
                   
                     
                }
                else{
                  
                     this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Error ! ",
                            message: result,
                            variant: "error"
                        })
                    );
                     
                }
                 
            
            
 
}

    
}