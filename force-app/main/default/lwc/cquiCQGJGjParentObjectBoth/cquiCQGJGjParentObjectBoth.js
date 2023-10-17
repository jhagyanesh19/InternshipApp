// basic import
import { track, api} from 'lwc';
import cqRecordForm from 'c/cqRecordForm';





// field and schema import

// Object_<Object api name without __c if present>
import OBJECT_CQ_GJ_SQX_PARENT_OBJECT__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c';


// Field_<field api name without __c if present>

import FIELD_NAME from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.Name';

import FIELD_OWNERID from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.OwnerId';

import FIELD_CQ_GJ_SQX_ACCOUNT_INFO__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_SQX_Account_Info__c';

import FIELD_CQ_GJ_DESIGNATION__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Designation__c';

import FIELD_CQ_GJ_SQX_USER__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_SQX_User__c';

import FIELD_CQ_GJ_DESCRIPTION__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Description__c';

import FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_SQX_Part_Family_info__c';

import FIELD_CQ_GJ_BUISNESS_TITLE__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Buisness_Title__c';

import FIELD_CQ_GJ_SQX_PART_INFO__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_SQX_Part_Info__c';

import FIELD_CQ_GJ_PARENT_QUERY__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Parent_Query__c';

import FIELD_CQ_GJ_INITIATED_DATE__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Initiated_Date__c';

import FIELD_CQ_GJ_TARGET_DATE__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Target_Date__c';

import FIELD_CQ_GJ_UPLOAD_CERTIFICATE__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Upload_Certificate__c';

import FIELD_CQ_GJ_WORKING_DAYS__C from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_Working_Days__c';





// additional Field_<field api name without __c if present>



// Lookup fields Field_<field api name without __c if present>_<name field>


    


    


    
import FIELD_CQ_GJ_SQX_ACCOUNT_INFO__NAME from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_SQX_Account_Info__r.Name';
    


    


    
import FIELD_CQ_GJ_SQX_USER__NAME from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_SQX_User__r.Name';
    


    


    
import FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__NAME from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_SQX_Part_Family_info__r.Name';
    


    


    
import FIELD_CQ_GJ_SQX_PART_INFO__NAME from '@salesforce/schema/CQ_GJ_SQX_Parent_Object__c.CQ_GJ_SQX_Part_Info__r.Name';
    


    


    


    


    


    



// import section custom label
    
        
import CQCQGJ_INFORMATION from '@salesforce/label/c.CQCQGJ_INFORMATION';
        
    
        
import CQCQGJ_SYSTEM_INFORMATION from '@salesforce/label/c.CQCQGJ_SYSTEM_INFORMATION';
        
    
        
import CQCQGJ_CUSTOM_LINKS from '@salesforce/label/c.CQCQGJ_CUSTOM_LINKS';
        
    


    


// generated to match the indext with the exact value field


// import as array to help in code generation below

const fields = [
 

    
    FIELD_NAME,
    
    FIELD_OWNERID,
    
    FIELD_CQ_GJ_SQX_ACCOUNT_INFO__C,
    
    FIELD_CQ_GJ_DESIGNATION__C,
    
    FIELD_CQ_GJ_SQX_USER__C,
    
    FIELD_CQ_GJ_DESCRIPTION__C,
    
    FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__C,
    
    FIELD_CQ_GJ_BUISNESS_TITLE__C,
    
    FIELD_CQ_GJ_SQX_PART_INFO__C,
    
    FIELD_CQ_GJ_PARENT_QUERY__C,
    
    FIELD_CQ_GJ_INITIATED_DATE__C,
    
    FIELD_CQ_GJ_TARGET_DATE__C,
    
    FIELD_CQ_GJ_UPLOAD_CERTIFICATE__C,
    
    FIELD_CQ_GJ_WORKING_DAYS__C,
    
    
    
        
    
        
    
        
    FIELD_CQ_GJ_SQX_ACCOUNT_INFO__NAME,
        
    
        
    
        
    FIELD_CQ_GJ_SQX_USER__NAME,
        
    
        
    
        
    FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__NAME,
        
    
        
    
        
    FIELD_CQ_GJ_SQX_PART_INFO__NAME,
        
    
        
    
        
    
        
    
        
    
        
    
];

const lookupDisplayFields = {
    
    
        

        

        
    "CQ_GJ_SQX_Account_Info__c": FIELD_CQ_GJ_SQX_ACCOUNT_INFO__NAME,
    

        

        
    "CQ_GJ_SQX_User__c": FIELD_CQ_GJ_SQX_USER__NAME,
    

        

        
    "CQ_GJ_SQX_Part_Family_info__c": FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__NAME,
    

        

        
    "CQ_GJ_SQX_Part_Info__c": FIELD_CQ_GJ_SQX_PART_INFO__NAME,
    

        

        

        

        

        

};

const LOOKUP_FILTERS = {"CQ_GJ_SQX_Part_Info__c":{"fields":["CQ_GJ_SQX_Part_Family_info__c"]},"CQ_GJ_SQX_Account_Info__c":{"filters":[{"field":"compliancequest__Active__c","operator":"eq","isDynamic":false,"value":"Yes"},{"field":"RecordTypeId","operator":"eq","isDynamic":false,"usv_function":"reference","usv_param":"Name","value":"Supplier"}],"logic":"and","fields":[]}};
const DYNAMIC_SOURCES = {"CQ_GJ_SQX_Part_Info__c":{"ns":"","componentname":"CQUI_GJ_Filter_Part_By_ProductFamily"}};
const FORM_RULES = {"CQ_GJ_SQX_Account_Info__c":{"transfer":[{"fields":["CQ_GJ_SQX_Account_Info__c"],"filter":"record.CQ_GJ_SQX_Account_Info__c   ","action":{"compliancequest__CQ_Owner__c":["CQ_GJ_SQX_User__c"],"compliancequest__CQ_Owner__r":["CQ_GJ_SQX_User__r"]}}],"setValues":[{"fields":["CQ_GJ_SQX_Account_Info__c"],"filter":"!record.CQ_GJ_SQX_Account_Info__c   ","action":{"CQ_GJ_SQX_User__c":null}}]},"CQ_GJ_Description__c":{"hidden":{"fields":["CQ_GJ_Designation__c"],"filter":"record.CQ_GJ_Designation__c == 'Daily Worker' "}},"CQ_GJ_Buisness_Title__c":{"required":{"fields":["CQ_GJ_Designation__c"],"filter":"record.CQ_GJ_Designation__c == 'Businessman' "}},"CQ_GJ_Target_Date__c":{"invoke":{"fields":["CQ_GJ_Target_Date__c"],"filter":"true","action":[{"name":"CQUI_GJ_DateSetter_AL_Flow","ns":""}]},"readonly":{"fields":["CQ_GJ_Parent_Query__c"],"filter":"record.CQ_GJ_Parent_Query__c   "}},"onLoad":{"invoke":{"action":[{"name":"CQUI_GJ_DateSetter_AL_Flow","ns":""}]}},"CQ_GJ_SQX_User__c":{"readonly":{"fields":["CQ_GJ_Target_Date__c"],"filter":"record.CQ_GJ_Target_Date__c   "}},"CQ_GJ_Parent_Query__c":{"readonly":{"fields":["CQ_GJ_Target_Date__c"],"filter":"record.CQ_GJ_Target_Date__c   "}},"CQ_GJ_Upload_Certificate__c":{"required":{"fields":["CQ_GJ_Target_Date__c"],"filter":"record.CQ_GJ_Target_Date__c   "}}};
const FORMULA_FIELDS = {};

export default class cquiCQGJGjParentObjectBoth  extends cqRecordForm {
    
    @track
    sectionHider = {};
    fieldsToTrack = [];
    saveImmediate = false;

    constructor() {
        super();
        this.init(OBJECT_CQ_GJ_SQX_PARENT_OBJECT__C,fields,lookupDisplayFields);
        
        
        this.sectionHider = {"expando_unique_id_1":true,"expando_unique_id_2":true,"expando_unique_id_3":true}

        // Extend rules
        this.lookupFilters = LOOKUP_FILTERS;
        this.dynamicSources = DYNAMIC_SOURCES;
        this.inputFormRules = FORM_RULES;
        this.systemFormRules = FORMULA_FIELDS;
        this.picklistValueSource = {
            
        };
        this.uiType = {"CQ_GJ_Upload_Certificate__c":{"type":"file","showFilePicker":true,"shareContent":true}};
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

    
    get v_CQ_GJ_SQX_ACCOUNT_INFO__C() {
        return this.getValueFor(FIELD_CQ_GJ_SQX_ACCOUNT_INFO__C.fieldApiName);
    }
    get f_CQ_GJ_SQX_ACCOUNT_INFO__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_SQX_ACCOUNT_INFO__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_SQX_ACCOUNT_INFO__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_SQX_ACCOUNT_INFO__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_SQX_ACCOUNT_INFO__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_DESIGNATION__C() {
        return this.getValueFor(FIELD_CQ_GJ_DESIGNATION__C.fieldApiName);
    }
    get f_CQ_GJ_DESIGNATION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_DESIGNATION__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_DESIGNATION__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_DESIGNATION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_DESIGNATION__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_SQX_USER__C() {
        return this.getValueFor(FIELD_CQ_GJ_SQX_USER__C.fieldApiName);
    }
    get f_CQ_GJ_SQX_USER__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_SQX_USER__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_SQX_USER__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_SQX_USER__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_SQX_USER__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_DESCRIPTION__C() {
        return this.getValueFor(FIELD_CQ_GJ_DESCRIPTION__C.fieldApiName);
    }
    get f_CQ_GJ_DESCRIPTION__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_DESCRIPTION__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_DESCRIPTION__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_DESCRIPTION__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_DESCRIPTION__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_SQX_PART_FAMILY_INFO__C() {
        return this.getValueFor(FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__C.fieldApiName);
    }
    get f_CQ_GJ_SQX_PART_FAMILY_INFO__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_SQX_PART_FAMILY_INFO__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_SQX_PART_FAMILY_INFO__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_BUISNESS_TITLE__C() {
        return this.getValueFor(FIELD_CQ_GJ_BUISNESS_TITLE__C.fieldApiName);
    }
    get f_CQ_GJ_BUISNESS_TITLE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_BUISNESS_TITLE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_BUISNESS_TITLE__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_BUISNESS_TITLE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_BUISNESS_TITLE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_SQX_PART_INFO__C() {
        return this.getValueFor(FIELD_CQ_GJ_SQX_PART_INFO__C.fieldApiName);
    }
    get f_CQ_GJ_SQX_PART_INFO__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_SQX_PART_INFO__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_SQX_PART_INFO__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_SQX_PART_INFO__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_SQX_PART_INFO__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_PARENT_QUERY__C() {
        return this.getValueFor(FIELD_CQ_GJ_PARENT_QUERY__C.fieldApiName);
    }
    get f_CQ_GJ_PARENT_QUERY__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_PARENT_QUERY__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_PARENT_QUERY__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_PARENT_QUERY__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_PARENT_QUERY__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_INITIATED_DATE__C() {
        return this.getValueFor(FIELD_CQ_GJ_INITIATED_DATE__C.fieldApiName);
    }
    get f_CQ_GJ_INITIATED_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_INITIATED_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_INITIATED_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_INITIATED_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_INITIATED_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_TARGET_DATE__C() {
        return this.getValueFor(FIELD_CQ_GJ_TARGET_DATE__C.fieldApiName);
    }
    get f_CQ_GJ_TARGET_DATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_TARGET_DATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_TARGET_DATE__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_TARGET_DATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_TARGET_DATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_UPLOAD_CERTIFICATE__C() {
        return this.getValueFor(FIELD_CQ_GJ_UPLOAD_CERTIFICATE__C.fieldApiName);
    }
    get f_CQ_GJ_UPLOAD_CERTIFICATE__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_UPLOAD_CERTIFICATE__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_UPLOAD_CERTIFICATE__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_UPLOAD_CERTIFICATE__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_UPLOAD_CERTIFICATE__C.fieldApiName].fieldApiName);
    }

    
    get v_CQ_GJ_WORKING_DAYS__C() {
        return this.getValueFor(FIELD_CQ_GJ_WORKING_DAYS__C.fieldApiName);
    }
    get f_CQ_GJ_WORKING_DAYS__C() {
        let val=this.fieldsInfo ? this.fieldsInfo[FIELD_CQ_GJ_WORKING_DAYS__C.fieldApiName] : {};
        return val;
    }

    get d_CQ_GJ_WORKING_DAYS__C() {
        return lookupDisplayFields[FIELD_CQ_GJ_WORKING_DAYS__C.fieldApiName] && this.getValueFor(lookupDisplayFields[FIELD_CQ_GJ_WORKING_DAYS__C.fieldApiName].fieldApiName);
    }

    


    
        
    get CQCQGJ_INFORMATION() {
        return CQCQGJ_INFORMATION;
    }
        
    
        
    get CQCQGJ_SYSTEM_INFORMATION() {
        return CQCQGJ_SYSTEM_INFORMATION;
    }
        
    
        
    get CQCQGJ_CUSTOM_LINKS() {
        return CQCQGJ_CUSTOM_LINKS;
    }
        
    
}