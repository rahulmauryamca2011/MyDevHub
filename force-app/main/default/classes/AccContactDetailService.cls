public class AccContactDetailService {
    @AuraEnabled
    public static Account getAccountDetails(Id accountId, string conTitle) {
        Account accObj = [SELECT Id, Name,
                          (SELECT Id, Name,Lastmodifieddate, AccountId,Title, Add_Case__c, View_Case__c FROM Contacts WHERE Title =: conTitle), 
                          (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id =: accountId];
        return accObj;
    }
    @AuraEnabled
    public static integer FindChildMatter(Id recordId) {
        System.debug('recordId::'+recordId);
        integer count=0;
        for(Contact conObj : [SELECT Id,(select id from cases) FROM Contact Where id =: recordId])
        {
        	if(conObj.cases != null && conObj.cases.size()>0)
            {
            	count = conObj.cases.size()  ;  
            }
           
        }
        return count;
    }
    @AuraEnabled
    public static void deleteRecord(Id recordId) {
        System.debug('recordId::'+recordId);
        Contact conObj = [SELECT Id FROM Contact Where Id =: recordId];
        DELETE conObj;
    }
    
   
}