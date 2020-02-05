public class AccountHierarchyCtrl{

    public Account CurrAcc {get;set;}
    public list<WrapAc> lstWrapAc{get;set;}
    public AccountHierarchyCtrl(ApexPages.StandardController Ctrl)
    {
        lstWrapAc = new list<WrapAc>();
        this.CurrAcc = (Account)Ctrl.getRecord();
        string recid=  currAcc.id;
        CurrAcc = new account();
        CurrAcc = [SELECT name,AnnualRevenue,ParentId, BillingCity, BillingCountry,parent.name,parent.AnnualRevenue,parent.BillingCity, parent.BillingCountry,(SELECT name,AnnualRevenue,ParentId, BillingCity, BillingCountry from ChildAccounts) from account where id=:recid];
        if(CurrAcc.Parentid != null)
        {
            for(Account ac:  [SELECT name,AnnualRevenue,ParentId, BillingCity, BillingCountry,(SELECT name,AnnualRevenue,ParentId, BillingCity, BillingCountry from ChildAccounts) from account where parentid =:CurrAcc.Parentid ])
            {
               WrapAc obj = new WrapAc();
               obj.acc =ac;
               if(ac.ChildAccounts.size()>0)
               {
                   obj.lstAc.addAll(ac.ChildAccounts);
               }
               
               lstWrapAc.add(obj);
            }
        }
        else
        {
             WrapAc obj = new WrapAc();
             obj.acc =CurrAcc;  
             if(CurrAcc.ChildAccounts.size()>0)
            {
               obj.lstAc.addAll(CurrAcc.ChildAccounts);
            }
               
               lstWrapAc.add(obj);
        }
        
    } 
    public class WrapAc
    {
        public account acc{get;set;}
        public list<Account> lstAc{get;set;}
        public WrapAc()
        {
            acc = new account();
            lstAc = new list<Account>();   
        }
    }
}