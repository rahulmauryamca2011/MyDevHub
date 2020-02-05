@istest
public class testResource {

    static testmethod void resourcetest()
    {
       // for (integer i =0 ; i >= 2; i++)
       // {
      	account acc = new account();
        acc.name ='raja' ;
        acc.country__c = 'India';
        acc.phone = '9990100715';
        insert acc;
       // }
        
        clsdmlonacc accdml = new clsdmlonacc();
        
    }
    
    
    
}