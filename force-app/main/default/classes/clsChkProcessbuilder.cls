public class clsChkProcessbuilder{

public class clsInvocablevariable{
@InvocableVariable
public ID ContactID;
@InvocableVariable
public string Type;  

}

@InvocableMethod
public static void UpdateTask(list<clsInvocablevariable> InvCon){

list<task> lstupserttask = new list<task>();

for(clsInvocablevariable requestObj:InvCon){
 System.debug('requestObj.Contactid@@:' + requestObj.ContactID);
 System.debug('requestObj.Type@@:' + requestObj.Type);
   // for (Contact lstcon : con){
    list<task> LstTask = [select ID,status,Types__c from Task where whoid=: requestObj.ContactID and Types__c =: requestObj.Type];
 
 System.debug('Task update start@@:' + lstupserttask );   
  for (Task tt:LstTask ){
    
   // if ((lstcon.Type_1__c == true && tt.Types__c == 'Type 1') || (lstcon.Type_2__c == true && tt.Types__c == 'Type 2') || (lstcon.Type_3__c == true && tt.Types__c== 'Type 3')||(lstcon.Type_4__c == true && tt.Types__c== 'Type 4')) {
        tt.status = 'InProgress';
        lstupserttask.add(tt);
  //  }    
    }
//}

}

update lstupserttask;
//return true;
}


}