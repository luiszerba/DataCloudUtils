import { LightningElement,api,wire,track } from 'lwc';
import getEngagementListFromContact from '@salesforce/apex/DF_DataCloudEngagementUtil.getEngagementListFromContact'

const columns = [
    { label: '#Id', fieldName: 'transaction_id__c', type: 'text'},
    { label: 'Data', fieldName: 'date__c', type: 'date', typeAttributes: {day: 'numeric', month: 'numeric', year: 'numeric'}},
    { label: 'Amount', fieldName: 'value__c', type: 'currency' },
    { label: 'Category', fieldName: 'purchase_category__c', type: 'text'}
];

export default class DF_EngagementData extends LightningElement {

    @track data;
    columns = columns;

    @api recordId;
    @track error;

    @wire(getEngagementListFromContact, {sourceRecordId: '$recordId'} )
    engagementData({error, data}){
        if(data){
            this.data = data;
            this.error = undefined;
        }else if(error) {
            this.error = error;
            this.record = undefined;
        }
    }



}