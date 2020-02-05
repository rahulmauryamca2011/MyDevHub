Public class AccountDetail
{
public List<Account> Accounts {get; set;}
public List<Contact> Contacts {get; set;} 
public string Accountname{get;set;}

String AccountId;
public void setAccountId(String val)
{
this.AccountId=val;
}

public String getAccountId()
{
return this.AccountId;
}


public void getdata(){}

public void fetchdata()
{
    system.debug('coming here======='+Accountname);
    Accounts = [select ID from Account where Name =: Accountname]; 
    Contacts = [select ID,Phone,Name from Contact where Accountid =: Accounts[0].ID];
    system.debug('accounts ======='+accounts );
    
} 

Public void EditAccount()
{
    update Contacts ;

}



}