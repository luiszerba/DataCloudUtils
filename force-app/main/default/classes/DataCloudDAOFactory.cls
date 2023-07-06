public with sharing class DataCloudDAOFactory {

    public enum DAO_TYPE {API}

    private DataCloudDAOFactory(){}

    public static DataCloudDAO getDataCloudDAO(DAO_TYPE type){

        if(DAO_TYPE.API == type){
            JWTSessionHandler instance = JWTSessionHandler.getInstance();
            return new DataCloudAPIDAOImpl(
                JWTSessionHandler.getInstance()
                    .getDataCloudBearerToken(instance.getBearerToken())
            );
        }
        return null;
    }
}