import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Internship__c';
import Name from '@salesforce/schema/Internship__c.Name';
import Status from '@salesforce/schema/Internship__c.Status__c';
import Email from '@salesforce/schema/Internship__c.Email__c';
import InternshipApplicationDeadline from '@salesforce/schema/Internship__c.InternshipApplicationDeadline__c';
import InternshipStartDate from '@salesforce/schema/Internship__c.InternshipStartDate__c';
import InternshipEndDate from '@salesforce/schema/Internship__c.InternshipEndDate__c';
import WorkingHours from '@salesforce/schema/Internship__c.WorkingHours__c';
import Stipend from '@salesforce/schema/Internship__c.Stipend__c';
import WorkingDays from '@salesforce/schema/Internship__c.WorkingDays__c';
import RoleDescription from '@salesforce/schema/Internship__c.RoleDescription__c';
import PostedBy from '@salesforce/schema/Internship__c.PostedBy__c';
import WorkingArea from '@salesforce/schema/Internship__c.WorkingArea__c';
import Duration from '@salesforce/schema/Internship__c.Duration__c';
import InternshipLevel from '@salesforce/schema/Internship__c.InternshipLevel__c';
import Opennings from '@salesforce/schema/Internship__c.Opennings__c';
import RequiredSkills from '@salesforce/schema/Internship__c.RequiredSkills__c';


//importing all of the fieldds for creating the record

  
export default class CreateAccountRecord extends LightningElement {
    objectApiName=ACCOUNT_OBJECT;
    fields = [Name,Status, Email,InternshipApplicationDeadline, InternshipStartDate,InternshipEndDate, WorkingHours, Stipend, WorkingDays, RoleDescription
    ,PostedBy,WorkingArea, Duration, InternshipLevel,Opennings, RequiredSkills
    ];

    handleSuccess(event){
        const toastEvent=new ShowToastEvent({
            title:"Internship has been created successfully !",
            message: " ",
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }
}