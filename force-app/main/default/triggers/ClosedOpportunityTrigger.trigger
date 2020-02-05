trigger ClosedOpportunityTrigger on Opportunity (before delete) {
    List<Task> taskListToInsert = new List<Task>(); 
    set<id> setacids = new set<id>();
    for(Opportunity opp : trigger.old)
    {
        if(opp.StageName == 'Closed Won')
        {
            setacids.add(opp.Accountid);
            
        }
    }
    if(setacids.size()>0)
    {
         
          trigger.old[0].adderror('you can not delete');
          system.debug('after add error======');
          opportunityTriggerHandler1.UpdateAccount(setacids ); 
    }
    
    
}