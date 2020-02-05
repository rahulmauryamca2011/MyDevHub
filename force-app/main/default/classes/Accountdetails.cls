@RestResource(urlMapping='/showAccountdetails/')
global class Accountdetails
{
@httpget
global static Account getaccount()
{

restresponse res = restcontext.response;
restrequest req = restcontext.request;

String Accountid = req.requestURI.substring(req.requestURI.lastindexof('/')+1);
 
//list<Account> lstacc = new list<Account>();
 
Account acc = [select name,phone from Account where id =: Accountid];

return acc;


}

@httppost
global static void getaccount(string name ,string phone ,string Accountnumber)
{

restresponse res = restcontext.response;
restrequest req = restcontext.request;

//String Accountid = req.requestURI.substring(req.requestURI.lastindexof('/')+1);
 
//list<Account> lstacc = new list<Account>();
 
//Account acc = [select name,phone from Account where id =: Accountid];

account acc = new account();
acc.name = name ;
acc.phone = phone ;
acc.Accountnumber= Accountnumber;
insert acc;

//return acc;


}

}