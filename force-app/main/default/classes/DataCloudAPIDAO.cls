public virtual class DataCloudAPIDAO {

    private JWTBearerInfo bearer;

    public DataCloudAPIDAO(JWTBearerInfo dataCloudBearer){
        this.bearer = dataCloudBearer;
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
        
        return parseHttpResponseFromQueryAPI(header, response.getBody());

    }

}