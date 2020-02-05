public class oAuthTest
{
    public string clientID{get;set;}
    public string AccessToken{get;set;}
    public string AuthToken{get;set;}
    public oAuthTest()
    {
        AuthToken= apexpages.currentpage().getparameters().get('code');
        clientID ='3MVG9d8..z.hDcPIct1bR6yns7vcp.NhQ2GMz.Iu6mb.dpUK0ojzLPqkjncw2pfW7lZ_m5m69ahNoSkmipMxp';
    }
    public pagereference RequestAuthToken()
    {
        string requestAuth ='https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id='+clientID+'&redirect_uri=https://ge-ip--sit--c.cs13.visual.force.com/apex/Rahultest';
        
        return new pagereference(requestAuth ) ;

        
    }
    public pagereference  FetchAccessToken()
    {
      httprequest   req = new httprequest();
      req.setendpoint('https://login.salesforce.com/services/oauth2/token');
      req.setmethod('POST');
      req.setbody('grant_type=authorization_code&code='+AuthToken+'&client_id='+clientID+'&client_secret=7696958329786740286&redirect_uri=https://ge-ip--sit--c.cs13.visual.force.com/apex/Rahultest');
      http htp = new http();
      httpresponse  res = htp.send(req);
      system.debug('access token--'+res.getbody());
      return null;
      
    }
}