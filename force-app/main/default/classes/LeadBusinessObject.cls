public class LeadBusinessObject{
        public cls_Leads[] Leads;
         public class cls_Leads {
            public String LastName;	//test
            public String FirstName;	//gmt
            public String Phone;	//(510) 366-7279
            public String Email;	//t@g.com
            public String Company;
            public String Status; 
        }
        public static LeadBusinessObject parse(String json){
            return (LeadBusinessObject) System.JSON.deserialize(json, LeadBusinessObject.class);
        }
    }