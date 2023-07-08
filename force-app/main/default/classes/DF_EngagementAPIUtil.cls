public with sharing class DF_EngagementAPIUtil {

    //Lembrar de autorizar o remote site settings : https://ddp0000017dismam.lightning.force.com/services/a360/token
    @AuraEnabled(cacheable=true)
    public static List<Map<String,Object>> getEngagementListFromContactByAPI(String sourceRecordId){
        try {
            Contact contactInfo = [SELECT CPF__c,id FROM Contact WHERE id = :sourceRecordId LIMIT 1];

            String query = 'SELECT cpf__c, purchase_category__c, transaction_id__c, value__c, date__c FROM S3_TransactDatabasev2__dlm LIMIT 10';

            String [] header = new String[]{'cpf__c','transaction_id__c','value__c','purchase_category__c','date__c'};

            return DataCloudDAOFactory.getDataCloudDAO(
                DataCloudDAOFactory.DAO_TYPE.API).queryAll(header, query);
            
        } catch (Exception e) {
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String,Object>> getEngagementListFromEntityNameByMatchOnField(String recordId, String entityName, String matchOnField){
        try {
            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}