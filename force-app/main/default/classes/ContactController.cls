public with sharing class ContactController {
	
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, FirstName, LastName, Title, Phone, Email FROM Contact LIMIT 10];
    }
     @AuraEnabled(cacheable=true)
    public static List<contact> findContacts(String searchIdKey,string searchNamekey) {
       String key = '%' + searchIdKey + '%';
        String Namekey = '%' + searchNamekey + '%';
         List<wrapClass> lst = new  List<wrapClass>();
        return [SELECT Id, Name, Title, Phone, Email FROM Contact WHERE (Name LIKE :key AND name like :Namekey) ];
        
    }
     @AuraEnabled(cacheable=true)
    public static List<contact> findContacts1(string searchNamekey) {
      String Namekey = '%' + searchNamekey + '%';
         List<wrapClass> lst = new  List<wrapClass>();
        return [SELECT Id, firstname,lastname, Title, Phone, Email FROM Contact WHERE ( name like :Namekey) ];
        
    }
    @AuraEnabled(cacheable=true)
    public static list<Contact> findContactsWithName(string searchKey) {
        system.debug('searchNamekey=='+searchKey);
         String Namekey = '%' + searchKey + '%';
         List<wrapClass> lst = new  List<wrapClass>();
        return  [SELECT Id, Name, Title, Phone, Email FROM Contact where name like :Namekey];
       /* for(Contact obj : [SELECT Id, Name, Title, Phone, Email FROM Contact where name like :Namekey])
        {
            lst.add(new wrapclass(obj.id,obj.name));
           
            
        } 
        
        system.debug('lst======='+lst);

        return lst;*/
    }
    
     @AuraEnabled(cacheable=true)
    public static List<opportunity> getOpptyOverAmount() {
        return [SELECT Id, Name, stagename FROM opportunity LIMIT 10];
    }
     @AuraEnabled(cacheable=true)
    public static opportunity updateOpptyStage(string stage,list<opportunity> opptiesOverAmount) {
        system.debug('pass from here==='+opptiesOverAmount);
        system.debug('stage==='+stage);
        for(opportunity obj :opptiesOverAmount)
            obj.stagename=stage;
        
        update opptiesOverAmount;
        return new opportunity();
    }
    public class wrapClass
    {
        public string label;
        public string value;
        public wrapClass(string l,string v)
        {
            label =l;
            value=v;
        }
        
    }
}