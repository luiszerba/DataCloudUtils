public with sharing class DF_EngagementAPIUtil {

    //Lembrar de autorizar o remote site settings : https://ddp0000017dismam.lightning.force.com/services/a360/token
    @AuraEnabled(cacheable=true)
    public static string getEngagementListFromContactByAPI(String sourceRecordId){
        try {
            JWTSessionHandler instance = JWTSessionHandler.getInstance();
            instance.getDataCloudBearerToken(instance.getBearerToken());
            //TODO Develop DAO class to perform API request with DataCloudBearerToken
            return 'Ok';
            
        } catch (Exception e) {
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}