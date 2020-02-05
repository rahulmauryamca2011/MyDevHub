trigger trgCretaeoppCon on Account (after insert ,after update) {
 ClsAccOpp obj = new ClsAccOpp();
 
if (trigger.isinsert)
{
    obj.InsertValues(trigger.new);
     
}

if (trigger.isupdate)
{
    list<Account> acc = new list<Account>();
    for(Account con:trigger.new)
    {
        if(Trigger.oldMap.get(con.Id).country__c != con.country__c)
        {
        acc.add(con) ;
         
        }    
      }
      obj.InsertValues(acc);  
}

if (trigger.isDelete)
{
    obj.deleteAccount(trigger.old);

}

}