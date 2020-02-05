@istest(seeAllData = false)
public class UpdateDataTest
{
    private static Account acc;
    
    public static testmethod void ValidateBatch()
    {
        acc = new Account();
        acc.Name='test';
        insert acc;
        
        list<Opportunity> lstOpp = new list<opportunity>();
        lstOpp.add(new Opportunity(name='test-2017-18',stagename='Prospecting', closedate=system.today(),accountid=acc.id));
        insert lstOpp;
        
        Candidate__c objCandidate = new Candidate__c(name='test',Account__c=acc.id);
        insert objCandidate;
        database.executebatch(new UpdateData());
        
    }
}