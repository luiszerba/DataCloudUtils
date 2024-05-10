import { LightningElement,api,wire,track } from 'lwc';
import getEngagementListFromContact from '@salesforce/apex/DF_DataCloudEngagementUtil.getEngagementListFromContact'

const columns = [
    { label: '#Id', fieldName: 'interaction_id__c', type: 'text'},
    { label: 'Data', fieldName: 'date__c', type: 'date', typeAttributes: {day: 'numeric', month: 'numeric', year: 'numeric'}},
    { label: 'Imóvel', fieldName: 'title__c', type: 'text'},
    { label: 'Detalhes', fieldName: 'property_url_information__c', type:'url'},
    { label: 'Valor', fieldName: 'price__c', type: 'text'}
];

/*'SELECT DataSourceObject__c,DataSource__c,KQ_cpf__c,KQ_interaction_id__c,aquecimento__c,area__c, '
+ ' banheiros__c,cpf__c,date__c,financiamento__c,garagem__c,id_imovel__c, '
+ ' interaction_id__c,mobilia__c,permuta__c,price__c,quartos__c,title__c,url__c,__datasourceentityname '
+ ' FROM restate_customer_nav_wt_fy25__dlm '
+ ' WHERE cpf__c = :cpf__c ORDER BY date__c DESC LIMIT 20';*/

export default class DF_EngagementData extends LightningElement {

    @track data;
    columns = columns;

    @api recordId;
    @track error;

    //clickedButtonLabel;

    @wire(getEngagementListFromContact, {sourceRecordId: '$recordId'} )
    engagementData({error, data}){
        if(data){
            console.log(JSON.stringify(data));
            this.data = data;
            this.error = undefined;
        }else if(error) {
            this.error = error;
            this.record = undefined;
        }
    }

    //handleClick(event){
    //    this.clickedButtonLabel = 'Botão Clicado';
    //}



}