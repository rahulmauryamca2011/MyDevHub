public class DownloadFile {
	@AuraEnabled(cacheable=true)
    public static list<contentversion> getDocumentList(Id contactId) {
       return [Select Id,contentdocumentid from contentversion limit 5];
       
    }

}