@restResource(urlmapping='/v5/account/*')
global class accountWebService
{
    @HttpGet
    global static WrapAccount fetchAccount()
    {
        restRequest req = restcontext.request;
        restresponse res =restcontext.response;
        WrapAccount obj = new WrapAccount();
        system.debug('req==='+req);
        string acid =req.requestURI.substring(req.requestURI.lastindexof('/')+1);
        system.debug('acid=='+acid);
        list<account> lstAc;
        if(acid =='account')
        {
            string name = req.params.get('name');
            string acnum= req.params.get('AccountNumber');
            system.debug('name=='+name+'==acnum=='+acnum);
            name = '%'+name+'%';
            lstAc = [select id,name,AccountNumber from account where name like :name AND accountnumber=:acnum];
            if(lstAc != null && lstAc.size()>0)
            {
                obj.lstAc = lstAc ;
                obj.strMsg ='fetch from name';    
            }
        }
        else
        {
            lstAc = [select id,name from account where id=:acid];
            if(lstAc != null && lstAc.size()>0)
            {
                obj.lstAc = lstAc ;
                obj.strMsg ='fetch from id';    
            }
        }
        
        
        return obj;
    }
    global class WrapAccount
    {
        list<Account> lstAc = new list<Account>();
        string strMsg ;
    }
    @HttpPost
    global static list<Account> CreateAccount(list<Account> lstAc)
    {
        //account objAc = new account(name=strName,accountnumber =acnum);
        insert lstAc;
        return lstAc;
        
    }
    /*@HttpPost
    global static list<account> UpdateAccount()
    {
        restRequest req = restcontext.request;
        restresponse res =restcontext.response;
        system.debug('req==='+req);
        string acid =req.requestURI.substring(req.requestURI.lastindexof('/')+1);
        system.debug('acid=='+acid);
        list<account> lstAc = new list<account>();
        if(acid =='account')
        {
            string name = req.params.get('name');
            string acnum= req.params.get('AccountNumber');
            system.debug('name=='+name+'==acnum=='+acnum);
            name = '%'+name+'%';
            for( Account obj :[select id,name,AccountNumber from account where name like :name])
            {
                obj.accountNumber = acNum;
                lstac.add(obj);    
            }
            
        }
        else
        {
            string acnum= req.params.get('AccountNumber');
            lstAc = [select id,name,AccountNumber  from account where id=:acid];
            lstAc[0].accountNumber = acNum;
        }
        update lstac; 
        
        return lstac;
    }*/
    
}