// apexWireMethodWithParams.js
import { LightningElement,wire, track } from 'lwc';
import findContactsWithName from '@salesforce/apex/ContactController.findContactsWithName';

/** The delay used when debouncing event handlers before invoking Apex. */
const DELAY = 300;

export default class searchContactWithRadio extends LightningElement {
    @track searchKey = '';
    @track isDisp=false;
    @wire(findContactsWithName, { searchKey: '$searchKey' })
    contacts;

    handleKeyChange(event) {
        this.isDisp = true;
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        if(searchKey === '')
            this.isDisp = false;

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, DELAY);
    }
}