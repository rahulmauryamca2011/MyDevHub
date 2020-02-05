trigger BatchApexErrorTrigger on BatchApexErrorEvent__e(after insert) {
    
   list<BatchLeadConvertErrors__c> bcr= new List<BatchLeadConvertErrors__c>();
    
    for(BatchApexErrorEvent__e event: trigger.new){
        
        BatchLeadConvertErrors__c  evrterror= new BatchLeadConvertErrors__c ();
        
        evrterror.AsyncApexJobId__c= event.AsyncApexJobId__c;
        evrterror.Records__c=event.JobScope__c;
        evrterror.StackTrace__c=event.StackTrace__c;     
        bcr.add(evrterror);    
    }
    
    if(bcr.size()>0){
        
        insert bcr;
    }

}