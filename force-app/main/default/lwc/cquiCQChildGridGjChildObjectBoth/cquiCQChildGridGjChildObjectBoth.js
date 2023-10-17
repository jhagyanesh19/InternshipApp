// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_CQ_GJ_SQX_CHILD_OBJECT__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.Name';

import FIELD_OWNERID from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.OwnerId';

import FIELD_CQ_GJ_SQX_PARENT_INFO__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_SQX_Parent_Info__c';

import FIELD_CQ_GJ_TITLE__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_Title__c';

import FIELD_CQ_GJ_CHILD_TYPE__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_Child_Type__c';

import FIELD_CQ_GJ_DATE_OF_BIRTH__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_Date_Of_Birth__c';

import FIELD_CQ_GJ_SQX_USER_INFO__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_SQX_User_info__c';

import FIELD_CQ_GJ_UPLOAD_MARKSHEET__C from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_Upload_Marksheet__c';

import FIELD_CREATEDBYID from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CreatedById';

import FIELD_LASTMODIFIEDBYID from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.LastModifiedById';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    
import FIELD_CQ_GJ_SQX_PARENT_INFO__NAME from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_SQX_Parent_Info__r.Name';
    


    


    


    


    
import FIELD_CQ_GJ_SQX_USER_INFO__NAME from '@salesforce/schema/CQ_GJ_SQX_Child_Object__c.CQ_GJ_SQX_User_info__r.Name';
    


    


    


    



// import section custom label
    
        
import CQCQCHILDGRID_INFORMATION from '@salesforce/label/c.CQCQCHILDGRID_INFORMATION';
        
    
        
import CQCQCHILDGRID_SYSTEM_INFORMATION from '@salesforce/label/c.CQCQCHILDGRID_SYSTEM_INFORMATION';
        
    
        
import CQCQCHILDGRID_CUSTOM_LINKS from '@salesforce/label/c.CQCQCHILDGRID_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_OWNERID,
    
    FIELD_CQ_GJ_SQX_PARENT_INFO__C,
    
    FIELD_CQ_GJ_TITLE__C,
    
    FIELD_CQ_GJ_CHILD_TYPE__C,
    
    FIELD_CQ_GJ_DATE_OF_BIRTH__C,
    
    FIELD_CQ_GJ_SQX_USER_INFO__C,
    
    FIELD_CQ_GJ_UPLOAD_MARKSHEET__C,
    
    FIELD_CREATEDBYID,
    
    FIELD_LASTMODIFIEDBYID,
    
    
    
        
    
        
    
        
    FIELD_CQ_GJ_SQX_PARENT_INFO__NAME,
        
    
        
    
        
    
        
    
        
    FIELD_CQ_GJ_SQX_USER_INFO__NAME,
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        

        
    "CQ_GJ_SQX_Parent_Info__c": FIELD_CQ_GJ_SQX_PARENT_INFO__NAME,
    

        

        

        

        
    "CQ_GJ_SQX_User_info__c": FIELD_CQ_GJ_SQX_USER_INFO__NAME,
    

        

        

        

};

const LOOKUP_FILTERS = {};
const DYNAMIC_SOURCES = {};
const FORM_RULES = {};
const FORMULA_FIELDS = {};

export default class cquiCQChildGridGjChildObjectBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_CQ_GJ_SQX_CHILD_OBJECT__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true,"expando_unique_id_3":true}

        // Extend rules
        this.lookupFilters = LOOKUP_FILTERS;
        this.dynamicSources = DYNAMIC_SOURCES;
        this.inputFormRules = FORM_RULES;
        this.systemFormRules = FORMULA_FIELDS;
        this.picklistValueSource = {
            
        };
        this.uiType = {"CQ_GJ_Upload_Marksheet__c":{"type":"file","showFilePicker":true,"shareContent":true}};
        this.parentRecordApi="";
        
    }


    @api
    get recordId() {
        return this._recordId;
    }
    set recordId(value) {
        this._recordId = value;
        this.parentId = value;
    }

    // getters for field value, display value and field metadata
    
    get v_NAME() {
        return this.getValueFor(FIELD_NAME.fieldApiName);
    }
    get f_NAME() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_NAME.fieldApiName] : {};
        return val;
    }

    get d_NAME() {
        return lookupDisplayFields[FIELD_NAME.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_NAME.fieldApiName].fieldApiName);
    }

    
    get v_OWNERID() {
        return this.getValueFor(FIELD_OWNERID.fieldApiName);
    }
    get f_OWNERID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_OWNERID.fieldApiName] : {};
        return val;
    }

    get d_OWNERID() {
        return lookupDisplayFields[FIELD_OWNERID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_OWNERID.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_SQX_PARENT_INFO__C() {
        return this.getValueFor(FIELD_CQ_GJ_SQX_PARENT_INFO__C.fieldApiName);
    }
    get f_CQ_GJ_SQX_PARENT_INFO__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_SQX_PARENT_INFO__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_SQX_PARENT_INFO__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_SQX_PARENT_INFO__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_SQX_PARENT_INFO__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_TITLE__C() {
        return this.getValueFor(FIELD_CQ_GJ_TITLE__C.fieldApiName);
    }
    get f_CQ_GJ_TITLE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_TITLE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_TITLE__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_TITLE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_TITLE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_CHILD_TYPE__C() {
        return this.getValueFor(FIELD_CQ_GJ_CHILD_TYPE__C.fieldApiName);
    }
    get f_CQ_GJ_CHILD_TYPE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_CHILD_TYPE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_CHILD_TYPE__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_CHILD_TYPE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_CHILD_TYPE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_DATE_OF_BIRTH__C() {
        return this.getValueFor(FIELD_CQ_GJ_DATE_OF_BIRTH__C.fieldApiName);
    }
    get f_CQ_GJ_DATE_OF_BIRTH__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_DATE_OF_BIRTH__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_DATE_OF_BIRTH__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_DATE_OF_BIRTH__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_DATE_OF_BIRTH__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_SQX_USER_INFO__C() {
        return this.getValueFor(FIELD_CQ_GJ_SQX_USER_INFO__C.fieldApiName);
    }
    get f_CQ_GJ_SQX_USER_INFO__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_SQX_USER_INFO__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_SQX_USER_INFO__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_SQX_USER_INFO__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_SQX_USER_INFO__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_UPLOAD_MARKSHEET__C() {
        return this.getValueFor(FIELD_CQ_GJ_UPLOAD_MARKSHEET__C.fieldApiName);
    }
    get f_CQ_GJ_UPLOAD_MARKSHEET__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_UPLOAD_MARKSHEET__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_UPLOAD_MARKSHEET__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_UPLOAD_MARKSHEET__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_UPLOAD_MARKSHEET__C.fieldApiName].fieldApiName);
    }

    
    get v_CREATEDBYID() {
        return this.getValueFor(FIELD_CREATEDBYID.fieldApiName);
    }
    get f_CREATEDBYID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CREATEDBYID.fieldApiName] : {};
        return val;
    }

    get d_CREATEDBYID() {
        return lookupDisplayFields[FIELD_CREATEDBYID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CREATEDBYID.fieldApiName].fieldApiName);
    }

    
    get v_LASTMODIFIEDBYID() {
        return this.getValueFor(FIELD_LASTMODIFIEDBYID.fieldApiName);
    }
    get f_LASTMODIFIEDBYID() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_LASTMODIFIEDBYID.fieldApiName] : {};
        return val;
    }

    get d_LASTMODIFIEDBYID() {
        return lookupDisplayFields[FIELD_LASTMODIFIEDBYID.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_LASTMODIFIEDBYID.fieldApiName].fieldApiName);
    }

    


    
        
    get CQCQCHILDGRID_INFORMATION() {
        return CQCQCHILDGRID_INFORMATION;
    }
        
    
        
    get CQCQCHILDGRID_SYSTEM_INFORMATION() {
        return CQCQCHILDGRID_SYSTEM_INFORMATION;
    }
        
    
        
    get CQCQCHILDGRID_CUSTOM_LINKS() {
        return CQCQCHILDGRID_CUSTOM_LINKS;
    }
        
    
}