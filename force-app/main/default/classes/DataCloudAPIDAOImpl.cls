public with sharing 
    class DataCloudAPIDAOImpl extends DataCloudAPIDAO implements DataCloudDAO{

    public DataCloudAPIDAOImpl(JWTBearerInfo dataCloudBearer){
        super(dataCloudBearer);
    }    

    public List<Map<String,Object>> queryAll(String [] header, String query){

        return this.requestDataCloudQueryAPI(header,query);
    }

    public Map<String,Object> queryById(String id,String query){
        return null;
    }


}