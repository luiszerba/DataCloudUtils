public with sharing class DF_DataCloudEngagementUtil {

    @AuraEnabled(cacheable=true)
    public static List<SObject> getEngagementListFromContact(String sourceRecordId) {

        try {

            System.debug('[sourceRecordId]:'+sourceRecordId);
            Contact contactInfo = [SELECT CPF__c,id FROM Contact WHERE id = :sourceRecordId LIMIT 1];
            
            Map<String,Object> contactBinds = new Map<String,Object>{
                'cpf__c' => contactInfo.CPF__c
            };

            /*String query = 
                'SELECT cpf__c, transaction_id__c, value__c, purchase_category__c,date__c '
                + ' FROM WDC_CreditCardTransactions__dlm'
                + ' WHERE cpf__c = :cpf__c ORDER BY date__c DESC LIMIT 20';*/
            String query = 
                'SELECT DataSourceObject__c,DataSource__c,KQ_cpf__c,KQ_interaction_id__c,aquecimento__c,area__c, '
                + ' banheiros__c,cpf__c,date__c,financiamento__c,garagem__c,id_imovel__c, '
                + ' interaction_id__c,mobilia__c,permuta__c,price__c,quartos__c,title__c,Property_URL_Information__c, url__c '
                + ' FROM restate_customer_nav_wt_fy25__dlm '
                + ' WHERE cpf__c = :cpf__c AND Property_URL_Information__c != \'\' ORDER BY date__c DESC LIMIT 20';
            
            List<SObject> engagementList = 
                Database.queryWithBinds(query,contactBinds,AccessLevel.SYSTEM_MODE);

            
            
            return engagementList.isEmpty()? null : engagementList;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }
}