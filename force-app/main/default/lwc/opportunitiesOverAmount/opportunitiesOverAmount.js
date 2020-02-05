// opportunitiesOverAmount.js
import { LightningElement, api, wire } from 'lwc';
//import { refreshApex } from '@salesforce/apex';
import getOpptyOverAmount from '@salesforce/apex/ContactController.getOpptyOverAmount';
import updateOpptyStage from '@salesforce/apex/ContactController.updateOpptyStage';

export default class OpportunitiesOverAmount extends LightningElement {
    @api amount;

    @wire(getOpptyOverAmount)
    opptiesOverAmount;

    handleClick(event) {
        this.amount = event.value;
        updateOpptyStage({
            stage: 'Won',
            opptiesOverAmount : this.opptiesOverAmount
        })
        .then(() => {
            //return refreshApex(this.opptiesOverAmount);
        })
        .catch((error) => {
            this.message = 'Error received: code' + error.errorCode + ', ' +
                'message ' + error.body.message;
        });
    }
}