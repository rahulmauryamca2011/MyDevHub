public without Sharing class ClsAccountContact {
    
    @AuraEnabled
    public static list<account> getaccount()
    {
        
        list<Account> lstacc =[select id,name,lastmodifieddate from Account];
        
        system.debug('hello' + lstacc);
        return lstacc;
    }

	@AuraEnabled
    public static list<Contact> getContact(id Accid)
    {
        list<Contact> lstcon = [select id,email,phone,lastname from Contact where Accountid =: Accid ];
        return lstcon;        
    }
}