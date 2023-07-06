public with sharing class JWTSessionHandler {

    private final static JWTSessionHandler instance = new JWTSessionHandler();
    private JWTSessionHandler(){}

    public static JWTSessionHandler getInstance(){
        return instance;
    }

    public JWTBearerInfo getDataCloudBearerToken(JWTBearerInfo jwtBearerInfo){
        if(jwtBearerInfo == null) 
            throw new JWTBearerTokenException('Please use the method getBearerToken first to proceed with Data Cloud authentication');

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint(jwtBearerInfo.getDataCloudTokenURI());
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody(jwtBearerInfo.getDataCloudTokenURIPayload());

        HttpResponse response = http.send(request);
        JWTBearerInfo jwtDataCloudBearerInfo = (JWTBearerInfo)JSON.deserializeStrict(response.getBody(), JWTBearerInfo.class);
        System.debug('[JWTSessionHandler.getDataCloudBearerToken()#jwtDataCloudBearerInfo]:'+jwtDataCloudBearerInfo);
        
        return jwtDataCloudBearerInfo;
    }

    public JWTBearerInfo getBearerToken(){

        configCDP_LWC__mdt configCDP_LWC = [SELECT MasterLabel, audience__c, issuer__c, subject__c, certificateName__c FROM configCDP_LWC__mdt LIMIT 1];

        if(configCDP_LWC == null)throw new JWTBearerTokenException('configCDP_LWC__mdt metadata type not found, please review this information and acess');

        Auth.JWT jwt = new Auth.JWT();
        
        jwt.setAud(configCDP_LWC.audience__c);
        jwt.setIss(configCDP_LWC.issuer__c);
        jwt.setSub(configCDP_LWC.subject__c);
        
        //Create the object that signs the JWT bearer token
        Auth.JWS jws = new Auth.JWS(jwt, configCDP_LWC.certificateName__c);
        
        //Get the resulting JWS in case debugging is required
        String token = jws.getCompactSerialization();
        
        //Set the token endpoint that the JWT bearer token is posted to
        String tokenEndpoint = 'https://login.salesforce.com/services/oauth2/token';
        
        //POST the JWT bearer token
        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);
        
        //Get the access token
        String accessToken = bearer.getAccessToken();
        JWTBearerInfo result = (JWTBearerInfo) JSON.deserializeStrict((String)bearer.getHttpResponse().getBody(), JWTBearerInfo.class);

        System.debug('[JWTSessionHandler.getBearerToken()#result]:\n'+result.toString());
        return result;
    }
}