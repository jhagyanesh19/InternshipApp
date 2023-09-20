// objectDetailDataTable.js

import { LightningElement, wire } from 'lwc';

import getObjectDetails from '@salesforce/apex/ObjectDetailController.getObjectDetails';

 

export default class ObjectDetailDataTable extends LightningElement {

  objectDetails;

 

    @wire(getObjectDetails)

    wiredObjectDetails({ error, data }) {

        if (data) {

            this.objectDetails = data;

        } else if (error) {

            console.error('Error fetching data: ', error);

        }

    }

}