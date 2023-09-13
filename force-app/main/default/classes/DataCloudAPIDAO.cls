public virtual class DataCloudAPIDAO {

    private JWTBearerInfo bearer;

    public DataCloudAPIDAO(JWTBearerInfo dataCloudBearer){
        this.bearer = dataCloudBearer;
    }  

    //https://developer.salesforce.com/docs/atlas.en-us.c360a_api.meta/c360a_api/c360a_api_metadata_api.htm
    public MetadataClass queryDataCloudMetadata(String entityType, String entityCategory, String entityName){
        
        String dataCloudEndpoint = 'https://' + this.bearer.instance_url + '/api/v1/metadata';

        String body = '?';

        if('DataLakeObject'.equals(entityType) 
            || 'DataModelObject'.equals(entityType) 
            || 'CalculatedInsight'.equals(entityType)){
                body += 'entityType='+entityType+'&';
        }
        if('Profile'.equals(entityCategory) 
            || 'Engagement'.equals(entityCategory) 
            || 'Related'.equals(entityCategory)){
                body += 'entityCategory='+entityCategory+'&';
        }
        if(entityName != null){
            body += 'entityName='+entityName+'&';
        }
        
        dataCloudEndpoint += body;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(dataCloudEndpoint);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', this.bearer.getAuthorizationBearerToDataCloudAPI());
        
        HttpResponse response = http.send(request);

        System.debug('DataCloudAPIDAO.queryDataCloudMetadata()#response'+response);
        System.debug('DataCloudAPIDAO.queryDataCloudMetadata()#response.getBody()'+response.getBody());
        
        return (MetadataClass)JSON.deserialize(response.getBody(), MetadataClass.class);
    }

    public static List<Map<String,Object>> parseHttpResponseFromQueryAPI(List<String> header, String response){
        
        Map<String, Object> parsedJson = (Map<String, Object>) JSON.deserializeUntyped(response);
        List<Object> data = (List<Object>) parsedJson.get('data');
        
        List<Map<String,Object>> result = new List<Map<String,Object>>();

        for(Object record: data){

            List<Object> fields = (List<Object>) record;
            
            Map<String,Object> recordMap = new Map<String,Object>();

            for(Integer i=0;i<header.size();i++){
                recordMap.put(header[i],fields[i]);
            }

            result.add(recordMap);
        }
        
        System.debug('[DataCloudAPIDAO.parseHttpResponseFromQueryAPI#result]'+result);

        return result;
        
    }
    
    public List<Map<String,Object>> requestDataCloudQueryAPI(List<String> header,String query){

        String dataCloudEndpoint = 'https://' + this.bearer.instance_url + '/api/v2/query';
        //System.debug('[DataCloudAPIDAO.requestDataCloudQueryAPI#dataCloudEndpoint]:' + dataCloudEndpoint);

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('sql',query);
        gen.writeEndObject();

        String body = gen.getAsString();

        //System.debug('[DataCloudAPIDAO.requestDataCloudQueryAPI#body]:' + body);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(dataCloudEndpoint);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', this.bearer.getAuthorizationBearerToDataCloudAPI());
        request.setBody(body);

        HttpResponse response = http.send(request);

        System.debug('DataCloudAPIDAO.requestDataCloudQueryAPI()#response'+response);
        System.debug('DataCloudAPIDAO.requestDataCloudQueryAPI()#response.getBody()'+response.getBody());
        
        return parseHttpResponseFromQueryAPI(header, response.getBody());

    }

}