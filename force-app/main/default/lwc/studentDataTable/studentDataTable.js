// objectDetailDataTable.js

import { LightningElement, wire } from 'lwc';

import getObjectDetails from '@salesforce/apex/ObjectDetailController.getObjectDetails';

 

export default class ObjectDetailDataTable extends LightningElement {

  objectDetails;

 

    @wire(getObjectDetails)
    //getting details from the getObjectDetails method from controller class

    wiredObjectDetails({ error, data }) {

        if (data) {

            this.objectDetails = data;

        } else if (error) {

            console.error('Error fetching data: ', error);

        }

    }

}