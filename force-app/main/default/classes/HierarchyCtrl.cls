public class HierarchyCtrl{

    public MyAccount parentAcc {get;set;}
    public Map<Id, List<Account>> childrenPerParent {get;set;}
    public Account accnt {get;set;}

    public class MyAccount {


      public Account acc {get;set;}
      public List<Opportunity> optyList {get;set;}
      public List<MyAccount> children {get;set;}

    public MyAccount(Account acc) {
        this.acc = acc;
        optyList = new List<Opportunity>();
        children = new List<MyAccount>();
    }

    public Boolean addChild(Id parentId, Account child) {
        if(acc.Id == parentId) {
            children.add(new MyAccount(child));
            return true;
        } else {
            Boolean result = false;
            Integer i = 0;
            do {
                MyAccount myacc = children[i];
                result = myacc.addChild(parentId, child);
                i++;
            } while(!result && i < children.size());
        }
        return false;
    }

    public Set<Id> getChildrenId() {
        Set<Id> accIds = new Set<Id>();
        for(MyAccount myacc : children) {
            accIds.add(myacc.acc.Id);
            accIds.addAll(myacc.getChildrenId());
        }
        return accIds;
    }

    public List<MyAccount> getChildrenList() {
        List<MyAccount> childrenList = new List<MyAccount>();
        childrenList.addAll(children);
        for(MyAccount myacc : children) {
            childrenList.addAll(myacc.getChildrenList());
        }
        return childrenList;
    }

    public Boolean addOpty(Id accId, Opportunity opty) {
        if(acc.Id == accId) {
            optyList.add(opty);
            return true;
        } else {
            Boolean result = false;
            Integer i = 0;
            do {
                MyAccount myacc = children[i];
                result = myacc.addOpty(accId, opty);
                i++;
            } while(!result && i < children.size());
        }
        return false;
    }
}

public HierarchyCtrl(ApexPages.StandardController Ctrl){
    this.accnt = (Account)Ctrl.getRecord();

    for(Account acc : [SELECT ParentId,  BillingCity, BillingCountry FROM Account WHERE ParentId != null]) {
    if(childrenPerParent.get(acc.ParentId) == null)
        childrenPerParent.put(acc.ParentId, new List<Account>());
    childrenPerParent.get(acc.ParentId).add(acc);
    }

    parentAcc =new MyAccount(accnt);
    getChildren(accnt.Id);

    Set<Id> accIds = parentAcc.getChildrenId();
    accIds.add(accnt.Id);

    
    List<MyAccount> myAccList = new List<MyAccount>();
    myAccList.add(parentAcc);
    myAccList.addAll(parentAcc.getChildrenList());

    } 



    public void getChildren(Id accId) {
    if(childrenPerParent.get(accId) != null) {
        for(Account a : childrenPerParent.get(accId)) {
            parentAcc.addChild(accId, a);
            getChildren(a.Id);
        }
    }




     } 
}