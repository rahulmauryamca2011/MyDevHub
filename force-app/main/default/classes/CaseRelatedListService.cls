public class CaseRelatedListService {
	@AuraEnabled
    public static Contact getCaseList(Id contactId) {
        Contact contactObj = [Select Id, Name, (Select Id, Subject, Status, Priority,CaseNumber From Cases) From Contact Where Id =: contactId];
        return contactObj;
    }
}