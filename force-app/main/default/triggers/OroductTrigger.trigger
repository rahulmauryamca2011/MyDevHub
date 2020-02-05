trigger OroductTrigger on Product__c (before insert) {

    if(trigger.isbefore && trigger.isInsert)
    {
        ProductTriggerHandelr.beforeInsert(trigger.new);
    }

}