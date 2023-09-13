import { LightningElement } from 'lwc';
import { api,wire,track } from 'lwc';
import getEngagementListFromEntityNameByMatchOnField from '@salesforce/apex/DF_EngagementAPIUtil.getEngagementListFromEntityNameByMatchOnField';

const columns = [
    { label: '#Id', fieldName: 'transaction_id__c', type: 'text'},
    { label: 'CPF', fieldName: 'cpf__c', type: 'text'},
    { label: 'Valor', fieldName: 'value__c', type: 'currency' },
    { label: 'Categoria', fieldName: 'purchase_category__c', type: 'text'}
];

export default class DynamicDataCloudTable extends LightningElement {

    @api
    propertyDMO;

    @api
    matchOn;

    @api
    propertyDMOFieldToMatch;

    @track data;
    columns = columns;

    @api recordId;
    @track error;

    @wire(getEngagementListFromEntityNameByMatchOnField, {recordId: '$recordId', entityName: '$propertyDMO', matchOnField: '$matchOn', propertyDMOFieldToMatch: '$propertyDMOFieldToMatch'} )
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