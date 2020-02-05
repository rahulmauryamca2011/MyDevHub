public class searchContactController {
    @AuraEnabled
    public static List <Contact> fetchContact(String searchKeyWord) {
        String searchKey = searchKeyWord + '%';
        List <Contact> lstOfContact = [select id, Name from contact
                                         where Name LIKE: searchKey LIMIT 500];
        return lstOfContact;
    }
}