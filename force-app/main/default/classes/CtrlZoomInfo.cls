public class CtrlZoomInfo
{
     @AuraEnabled(cacheable=true)
    public static List<Contact> getDisplayList(){

        
        return [select id ,name from contact limit 5];
    }
}