public class testClass
{
    public SalesOrder__c obj{get;set;}
     public testClass()
     {
         obj = new SalesOrder__c();
     } 
     
     public pagereference resetData()
     {
      // obj.Product__c ='';
       return null;
         
     }  
}