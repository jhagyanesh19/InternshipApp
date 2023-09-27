import { LightningElement,api, wire } from 'lwc';

import { RefreshEvent } from 'lightning/refresh';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
export default class abcd extends LightningElement {
   

    @api recordId;
    status='';

  

    handleApprove(){

       this.status='Hired';

        this.template.querySelector('[data-status]').value =this.status;
       
        this.template.querySelector('lightning-record-edit-form').submit() ;
        
        this.dispatchEvent(
            new ShowToastEvent({
                title: "HIRED !!! ",
                message: 'This Intern has been Selected!',
                variant: "success"
            })
        );
    }

 

    handleReject(){
      this.status = 'Rejected';
      this.template.querySelector('[data-status]').value =this.status;
    
        this.template.querySelector('lightning-record-edit-form').submit() ;
        this.dispatchEvent(
            new ShowToastEvent({
                title: "REJECTED !!! ",
                message: 'This Intern has been Rejected!',
                variant: "error"
            })
        );
       
    }


    
}