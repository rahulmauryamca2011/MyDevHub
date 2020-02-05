/* eslint-disable no-unused-vars */
import { LightningElement, wire, track } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import Email_FIELD from '@salesforce/schema/Contact.Email';
import ID_FIELD from '@salesforce/schema/Contact.Id';
import Language_FIELD from '@salesforce/schema/contact.Languages__c'

const cols = [
    { label: 'First Name', fieldName: 'FirstName', editable: true },
    { label: 'Last Name', fieldName: 'LastName', editable: true },
    { label: 'Title', fieldName: 'Title' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label : 'DoNotCall',fieldName: 'DoNotCall',type:'checkbox'},
    {label : 'Language', fieldName : 'Languages__c', type:'text',editable:true}
];
export default class DatatableUpdateExample extends LightningElement {

    @track error;
    @track columns = cols;
    @track draftValues = [];

    @wire(getContactList)
    contact;

    handleSave(event) {

        const fields = {};
        fields[ID_FIELD.fieldApiName] = event.detail.draftValues[0].Id;
        fields[FIRSTNAME_FIELD.fieldApiName] = event.detail.draftValues[0].FirstName;
        fields[LASTNAME_FIELD.fieldApiName] = event.detail.draftValues[0].LastName;
        fields[Language_FIELD.fieldApiName] = event.detail.draftValues[0].Languages__c;
        
        const recordInput = {fields};

        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
            // Clear all draft values
            this.draftValues = [];

            // Display fresh data in the datatable
            return refreshApex(this.contact);
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}