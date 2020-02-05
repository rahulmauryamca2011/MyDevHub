@istest
private class AccountHierarchyCtrlTest
{
    private static testmethod void TestAccountHierarchyCtrl()
    {
        list<Account> lstparentAc = new List<Account>();
        lstparentAc.add(new account(Name='Test1',country__c ='India'));
        lstparentAc.add(new account(Name='Test2',country__c ='India'));
        lstparentAc.add(new account(Name='Test3',country__c ='India'));
        lstparentAc.add(new account(Name='Test4',country__c ='India'));
        
        insert lstparentAc;
        Account obj = new account(name='testAc',parentId = lstparentAc[0].id,country__c ='India');
        insert obj;
        
        list<Account> lstChildtAc = new List<Account>();
        //Account ac1 = new account(Name='Test1');
        lstChildtAc.add(new account(Name='Test11',parentId = obj.id,country__c ='India'));
        lstChildtAc.add(new account(Name='Test21',parentId = obj.id,country__c ='India'));
        lstChildtAc.add(new account(Name='Test31',parentId = obj.id,country__c ='India'));
        lstChildtAc.add(new account(Name='Test41',parentId = obj.id,country__c ='India'));
        
        insert lstChildtAc;
        
        
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        
        AccountHierarchyCtrl controller = new AccountHierarchyCtrl(sc);
        
    }
}