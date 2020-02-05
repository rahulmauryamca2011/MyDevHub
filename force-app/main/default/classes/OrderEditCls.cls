public class OrderEditCls {
    public static  SalesOrder__c obj ;
	@AuraEnabled
    public static SalesOrder__c createBP(string recId){
    
        obj = new SalesOrder__c();
        obj =[select id,name,Open_next_Page__c from SalesOrder__c where id=:recId];
        return obj;
        
    }
    @AuraEnabled
    public static void createBP(){
    	system.debug('obj==='+obj);
        update  obj;
        
    }
}