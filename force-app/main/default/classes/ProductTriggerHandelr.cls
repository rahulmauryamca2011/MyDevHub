Public class ProductTriggerHandelr
{
    public static void beforeInsert(list<Product__c> triggerNew)
    {
    	set<string> oneConnectname = new set<string>();
        Id recTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Material').getRecordTypeId();
        map<string,Product__c> mapNameToProduct = new map<string,Product__c>();
        for(Product__c objProd :triggerNew)
        {
            if(objProd.One_Connect_Name__c	!= null && objProd.recordtypeid==recTypeId)
            {
                oneConnectname.add(objProd.One_Connect_Name__c);
            }
        }
        if(oneConnectname.size()>0)
        {
            Id recOneConnectTypeId = Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('One Connect').getRecordTypeId();
            list<Product__c> lstProd = new list<Product__c>();
            for(Product__c obj :[select id,name from Product__c where recordTypeId=:recOneConnectTypeId and name in :oneConnectname])
            {
                mapNameToProduct.put(obj.name,obj);
            }
            for(Product__c objProd :triggerNew)
            {
                if(objProd.One_Connect_Name__c	!= null && objProd.recordtypeid==recTypeId)
                {
                    if(mapNameToProduct.get(objProd.One_Connect_Name__c) == null)
                    {
                        Product__c ObjProduct = new Product__c();
                        ObjProduct.RecordTypeId = recOneConnectTypeId;
                        ObjProduct.name = objProd.One_Connect_Name__c;
                        mapNameToProduct.put(ObjProduct.name,ObjProduct);
                        lstProd.add(ObjProduct);
                    }
                    
                }
            }
            if(lstProd.size()>0)
                insert lstProd;
            
            
            for(Product__c objProd :triggerNew)
            {
                if(objProd.One_Connect_Name__c	!= null && objProd.recordtypeid==recTypeId)
                {
                    if(mapNameToProduct.get(objProd.One_Connect_Name__c) != null)
                    {
                        objProd.Product1__c = mapNameToProduct.get(objProd.One_Connect_Name__c).id;
                    }
                    
                }
            }
        }
    }
}