import { LightningElement,api,wire,track } from 'lwc';
import getEngagementListFromContactByAPI from '@salesforce/apex/DF_EngagementAPIUtil.getEngagementListFromContactByAPI'

const columns = [
    { label: '#Id', fieldName: 'transaction_id__c', type: 'text'},
    { label: 'CPF', fieldName: 'cpf__c', type: 'text'},
    { label: 'Valor', fieldName: 'value__c', type: 'currency' },
    { label: 'Categoria', fieldName: 'purchase_category__c', type: 'text'}
];

export default class DF_EngagementData extends LightningElement {

    @track data;
    columns = columns;

    @api recordId;
    @track error;

    @wire(getEngagementListFromContactByAPI, {sourceRecordId: '$recordId'} )
    engagementData({error, data}){
        if (data) {
            this.data = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
            console.error('[error]:', error);
        }
    }



}