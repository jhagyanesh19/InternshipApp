import {api } from 'lwc';
import CqGridForm from 'c/cqGridForm';
import CQ_GJ_SQX_CHILD_OBJECT__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c';


import FIELDS_PARENT_ID from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.Id';

import FIELDS_PARENT_NAME from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.Name';

import FIELDS_PARENT_CQ_GJ_PARENT_QUERY__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Parent_Query__c';





//import fields


import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_TITLE__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_Title__c';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_NAME from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.Name';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_CHILD_TYPE__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_Child_Type__c';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_DATE_OF_BIRTH__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_Date_Of_Birth__c';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_PARENT_INFO__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_SQX_Parent_Info__c';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_PARENT_INFO__R_NAME from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_SQX_Parent_Info__r.Name';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_USER_INFO__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_SQX_User_info__c';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_USER_INFO__R_NAME from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_SQX_User_info__r.Name';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_UPLOAD_MARKSHEET__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_Upload_Marksheet__c';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CREATEDDATE from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CreatedDate';

import FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_LASTMODIFIEDDATE from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.LastModifiedDate';


//import customlabels (Labels must not have space)

import CQCQCHILDGRID_NEW from '@salesforce/label/c.CQCQCHILDGRID_NEW';

import CQCQCHILDGRID_EDIT_MULTIPLE_CHILD from '@salesforce/label/c.CQCQCHILDGRID_EDIT_MULTIPLE_CHILD';




            
import CQCQCHILDGRID_SYSTEMINFO from '@salesforce/label/c.CQCQCHILDGRID_SYSTEMINFO';
            

//additonalFields added in query while fetching data
const additionalFields = [



];
const columns = [


    FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_TITLE__C,

        
    FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_NAME,

        
    FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_CHILD_TYPE__C,

        
    FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_DATE_OF_BIRTH__C,

        
    FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_PARENT_INFO__C,
                
            
    FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_USER_INFO__C,
                
            
    FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_UPLOAD_MARKSHEET__C,

        
               
              {
                
                    label: CQCQCHILDGRID_SYSTEMINFO,
                
                
                    type:'customComponent',
                
                

                    fields:[
                    
                    
                        {
                            fieldInfo:FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CREATEDDATE
                            
                            
                            
                        },
                        
                        {
                            fieldInfo:FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_LASTMODIFIEDDATE
                            
                            
                            
                        },
                        
                    ],
                

                
                    groupName:'systeminfoGroup'
                

               },
          
    
];

const parentFields = [

    FIELDS_PARENT_ID,

    FIELDS_PARENT_NAME,

    FIELDS_PARENT_CQ_GJ_PARENT_QUERY__C,

];

export default class cquiCQChildGridGjChildObjectGrid  extends CqGridForm {
    @api
    maxRows;

    @api
    maxColumns;

    @api
    gridType;

    @api
    flexipageRegionWidth;
    
    constructor() {
        super();
        this.fields = columns;
        this.columns = columns;
        this.mainObject = CQ_GJ_SQX_CHILD_OBJECT__C;
        this.relationalField = FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_PARENT_INFO__C; //todo use this in import
        this.additionalFields = additionalFields;
        this.parentFields = parentFields;

        
        this.headerActions = [{"label": CQCQCHILDGRID_NEW,"name":"std_new","componentName":"cqui-c-q-child-grid-gj-child-object-both"},{"label": CQCQCHILDGRID_EDIT_MULTIPLE_CHILD,"name":"showEditSelected","componentName":"cqui-c-q-child-grid-gj-child-object-both","component_namespace":"c-","action_type":"","bulk":true},];
        

        this.limitToRecordType = '';

        
        this.rowActions = [];
        

        
        this.rowFormRules = {"edit":{"fields":["CQ_GJ_Parent_Query__c","CQ_GJ_Parent_Query__c"],"visible":"parent.CQ_GJ_Parent_Query__c.value == 'Draft'   || parent.CQ_GJ_Parent_Query__c.value == 'In Progress'  "},"delete":{"fields":["CQ_GJ_Parent_Query__c","CQ_GJ_Parent_Query__c"],"visible":"parent.CQ_GJ_Parent_Query__c.value == 'Draft'   || parent.CQ_GJ_Parent_Query__c.value == 'In Progress'  "}};
        

        
        this.headerFormRules = {"std_new":{"fields":["CQ_GJ_Parent_Query__c","CQ_GJ_Parent_Query__c"],"visible":"parent.CQ_GJ_Parent_Query__c.value == 'Draft'   || parent.CQ_GJ_Parent_Query__c.value == 'In Progress'  "},"showEditSelected":{"fields":["CQ_GJ_Parent_Query__c","CQ_GJ_Parent_Query__c"],"visible":"parent.CQ_GJ_Parent_Query__c.value == 'Draft'   || parent.CQ_GJ_Parent_Query__c.value == 'In Progress'  "}};
        

        
        this.iconName = 'action:join_group';
        
        
    
        this.lookupFields[FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_PARENT_INFO__C.fieldApiName] = FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_PARENT_INFO__R_NAME;
                
                
            
        this.lookupFields[FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_USER_INFO__C.fieldApiName] = FIELDS_CQ_GJ_SQX_CHILD_OBJECT__C_CQ_GJ_SQX_USER_INFO__R_NAME;
                
                
            
               
                   

             
        

        
        this.sortOrder = 'DESC  NULLS LAST';
        

        

        

        

        

        this.componentName="c:cquiCQChildGridGjChildObjectGrid";

    }

    connectedCallback(){
        this.maxRowsToDisplay = this.maxRows;
        this.maxColumnsToDisplay = this.maxColumns;
        this.gridDesktopView = this.gridType;
    }

    @api 
    get recordId() {
        return this._recordId;
    }

    set recordId(value) {
        this._recordId = value;
    }

}