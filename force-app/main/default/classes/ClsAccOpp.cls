Public Class ClsAccOpp
{

public void InsertValues(list<Account> lstacc)
{
boolean flag = false;
 if (lstacc.size() > 0)
 {
 
    /* List<Country__c> Country= .getall().values(); */
     
     Map<String, Country__c> Country= Country__c.getAll();
     for(Account acc : lstacc)
     {
            for(Country__c cc : Country.values()) 
            {

                if (cc.country_name__c == acc.country__c) 
                {
    
                    flag = true;    
                    
                }
            }
            
            if (flag== true)
            {
                Contact obj= new Contact(
                LastName=acc.Name,
                Phone=acc.Phone,
                AccountId=acc.ID

                );
                insert obj;

            } 
            
            else
            {
                Opportunity obj = new Opportunity(
                Name=acc.Name,
                StageName= 'Prospecting',
                CloseDate= system.today(),
                accountID = acc.ID);
                insert obj;
            }

            
     }
 
 
 }

}

public void deleteAccount(list<account> lstacc)
{
    list<Opportunity> lstopp = new  list<Opportunity>();
    system.debug('start test--');
    lstopp = [select id from  Opportunity where Accountid IN : lstacc]; 
    system.debug('test val'+ lstopp);
    list<contact> lstconc = new  list<contact>();
system.debug('start test con--');
    lstconc= [select id from  contact where Accountid IN: lstacc]; 
        system.debug('test val'+ lstConc);    
    
    delete lstconc;
    delete lstopp;
    
    }

}