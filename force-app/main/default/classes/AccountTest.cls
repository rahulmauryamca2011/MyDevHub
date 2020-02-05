public class AccountTest
{
public string value {get; set;}
public list<Contact> lstconc {get; set;}
public list<opportunity> lstopp {get;set;}

public Opportunity newrecord {get;set;}
public integer rowNo{get;set;}
public AccountTest()
{

}

public List<SelectOption> getAccountlist() 
 {        
        List<Account> AccountList = [select id,Name from Account] ; 
        List<SelectOption> options = new List<SelectOption>();
        
        
     /*   options.add(new SelectOption('INDIA','INDIA'));
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('BRAZIL','BRAZIL'));  */
        
        for(account acc : accountlist)
        {
          options.add(new SelectOption(acc.id,acc.Name));  
        } 
        
        return options;
        
        
 }


public PageReference selectedvalue()
{
lstconc = [select ID,Name,Phone from Contact where accountid=: value];
lstopp = [select ID,name,Amount,description,StageName,CloseDate from opportunity where accountid =: value];

return null;
}


public PageReference addOpportunity()
{

newrecord = new opportunity();
if (lstopp != null)
{
    if (lstopp.size()>0)
    {
    lstopp.add(newrecord);
    }
}
return null;
}
public pagereference EditRec()
{
    system.debug('rowNo--'+rowNo);
    return null;
}

public PageReference SaveOpportunity()
{

if (lstopp != null)
{
    if (lstopp.size()>0)
    {
    list<opportunity> lstp = new list<opportunity>();
    for (opportunity op:lstopp)
    {
    
    op.accountid = value;  
    op.StageName= 'Prospecting'; 
    op.CloseDate = System.today() + 5 ;
    lstp.add(op);
    
    } 
    lstopp = lstp;
    upsert lstopp;
    }
}
return null;
}



}