public with sharing class JWTBearerInfo {

    private String access_token{get;set;}
    private String scope{get;set;}
    private String instance_url{get;set;}
    private String id{get;set;}
    private String token_type{get;set;}
    public String issued_token_type{get;set;}
    public Integer expires_in{get;set;}

    public JWTBearerInfo(String access_token, String scope, String instance_url, String id, String token_type) {
        this.access_token = access_token;
        this.scope = scope;
        this.instance_url = instance_url;
        this.id = id;
        this.token_type = token_type;
    }

    public String getDataCloudTokenURI(){
        if(this.instance_url == null) throw new JWTBearerTokenException('instance_url not defined');
        
        return this.instance_url + '/services/a360/token';
    }

    public String getDataCloudTokenURIPayload(){
        if(this.access_token == null) throw new JWTBearerTokenException('access_token not defined');

        String dataCloudRequestBody = 'grant_type=urn:salesforce:grant-type:external:cdp';
        dataCloudRequestBody += '&subject_token=' + this.access_token;
        dataCloudRequestBody += '&subject_token_type=urn:ietf:params:oauth:token-type:access_token';

        return dataCloudRequestBody;
    }

    
    public override String toString(){
        return '[access_token]:' + access_token +
                '\n[scope]:' + scope + 
                '\n[instance_url]:' + instance_url +
                '\n[id]:' + id +
                '\n[token_type]:' + token_type;
    }
}