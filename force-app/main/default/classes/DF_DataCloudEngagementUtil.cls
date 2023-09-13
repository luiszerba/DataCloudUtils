public with sharing class DF_DataCloudEngagementUtil {

    @AuraEnabled(cacheable=true)
    public static List<SObject> getEngagementListFromContact(String sourceRecordId) {

        try {

            System.debug('[sourceRecordId]:'+sourceRecordId);
            Contact contactInfo = [SELECT CPF__c,id FROM Contact WHERE id = :sourceRecordId LIMIT 1];
            
            Map<String,Object> contactBinds = new Map<String,Object>{
                'cpf__c' => contactInfo.CPF__c
            };

            String query = 
                'SELECT cpf__c, transaction_id__c, value__c, purchase_category__c,date__c '
                + ' FROM S3_TransactDatabasev2__dlm'
                + ' WHERE cpf__c = :cpf__c ORDER BY date__c DESC LIMIT 10';
            
            List<SObject> engagementList = 
                Database.queryWithBinds(query,contactBinds,AccessLevel.SYSTEM_MODE);
            
            return engagementList.isEmpty()? null : engagementList;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }
}