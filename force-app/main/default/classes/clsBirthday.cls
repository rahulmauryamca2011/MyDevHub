global class clsBirthday implements Database.Batchable<sObject>{

 
   global Database.QueryLocator start(Database.BatchableContext BC){
   list<string> lststr = new list<string>();
   lststr.add('shubhamshukla9911@gmail.com');
   lststr.add('rahulmaurya.mca2011@gmail.com'); 
   date dttoday;
   dttoday = Date.today();
      string query= 'select id,email,phone from contact where Birthdate =: dttoday' ;
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<Contact> scope){
    Emailtemplate Em = new emailtemplate();
    Em = [select id, name from EmailTemplate where developername = 'Birthday']; 
        
    for(contact c : scope)
    {
        Messaging.SingleEmailMessage objSingleEmail = new Messaging.SingleEmailMessage();
        list<string> str = new list<string>();
        str.add(c.email);
        
        objSingleEmail.setTargetObjectId(c.id);
        objSingleEmail.setToAddresses(str);    
        objSingleEmail.setTemplateId(Em.id);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {objSingleEmail});
    
    }
     
    }

   global void finish(Database.BatchableContext BC){
   }
}