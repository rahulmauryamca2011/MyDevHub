// apexWireMethodWithParams.js
import { LightningElement, track } from 'lwc';
import findContacts from '@salesforce/apex/ContactController.findContacts';

/** The delay used when debouncing event handlers before invoking Apex. */
const DELAY = 300;

export default class ApexWireMethodWithParams extends LightningElement {
    @track searchIdKey = '';
    @track searchNameKey = '';
    @track isDisp=false;
    @track options={};
    @track selectedVal;
    
    handleClientIDChange(event) {
        this.isDisp = true;
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        if(searchKey === '')
            this.isDisp = false;

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            this.searchIdKey = searchKey;
        }, DELAY);
    }
    handleClientNameChange(event) {
        this.isDisp = true;
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        if(searchKey === '')
            this.isDisp = false;

            findContacts({ searchIdKey: '$searchIdKey' ,searchNamekey :'$searchNameKey'})
            .then( result =>{
                  this.options =  result
            })
            .catch(error => {
                this.error = error;
            });
            
        
    }
}