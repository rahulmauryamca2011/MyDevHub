public class DisplayDoc
{
  
    public String pdf {
        get {
            return EncodingUtil.Base64Encode(Fetchatt.body);
        }
    }
     public Attachment Fetchatt {
        get {
            if (Fetchatt== null) {
                Fetchatt= [SELECT id,Body, ContentType, Name FROM Attachment WHERE parentid= 'a0m7F000004oAkE' limit 1];
                system.debug('test=='+EncodingUtil.Base64Encode(Fetchatt.body));
            }
            return Fetchatt;
        }
        private set;
    }

    public static void DeleteDoc(string docid)
    {    
        Attachment att =[SELECT Body, ContentType, Name FROM Attachment WHERE parentid= :docid  limit 1];    
        delete att ;
    }
}