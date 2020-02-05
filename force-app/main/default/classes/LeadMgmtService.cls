@RestResource(urlMapping='/LeadManagement/v1/*')
global with sharing class LeadMgmtService
{
    
    @HttpPost
    global static clswraper LeadCreate() 
    {
        RestRequest req = RestContext.request;
        // RestResponse res = RestContext.response;
        // responseWrapper responseJSON = new responseWrapper();
        clswraper responseJSON = new clswraper();
        
        try{
            string strName ;
            string strPhone ;
            string strEmail ;
            
            
            Set<String> SetName = new Set<String>();
            Set<String> SetPhone = new Set<String>();
            Set<String> SetEmail = new Set<String>();
            
            list<Lead> body = new list<Lead>();
            String jsonBody = req.requestBody.toString();
           if (!String.isBlank(jsonBody)) {
            LeadBusinessObject objlBO =  LeadBusinessObject.parse(jsonBody);
            
            system.debug('-------- start debug print json' + objlBO);
            
            for(LeadBusinessObject.cls_Leads objcls : objlBo.Leads)
            {
              //  system.debug('---- hello ' + objcls.Email);
                    SetPhone.add(objcls.Phone);
                    SetEmail.add(objcls.Email);
                    SetName.add(objcls.lastName);
                lead objlead = new lead();
                if (!String.isBlank(objcls.Email)){
                    objlead.Email = objcls.Email;
                }
                
                if (!String.isBlank(objcls.phone)){
                    objlead.phone =objcls.phone;
                }
                
                
                if (!String.isBlank(objcls.lastName)){
                    objlead.lastName = objcls.lastName;
                }
                
                if (!String.isBlank(objcls.FirstName)){
                    objlead.FirstName = objcls.FirstName;
                }
                
                
                if (!String.isBlank(objcls.Company)){
                    objlead.Company = objcls.Company;
                }
                
                if (!String.isBlank(objcls.Status)){
                    objlead.Status = objcls.Status;
                }
           	body.add(objlead);
                
            }
            
                system.debug('-------- start debug here body' +body);
               system.debug('-------- start debug here body' + SetPhone);
                //body = (list<Lead>)JSON.deserializeUntyped(jsonBody);
                //system.debug('=======' + body);
//                for(lead objlead : body){
                    
  //                  SetPhone.add(objlead.Phone);
   //                 SetEmail.add(objlead.Email);
    //                SetName.add(objlead.lastName);
                    
     //           } 
                
            }
            
            list<lead> RepeatLead =[select  lastname,Phone,Email,Company,Status from Lead where Lastname  IN : SetName and phone in : SetPhone and Email in : SetEmail];
           
            system.debug('===after soql' + RepeatLead);
            system.debug('===' + setEmail);
            system.debug('===' + setPhone);
            
            list<Lead> distinctRepeatedlist = new list<Lead>();
          //  list <Lead> finalLead = [select  ID,lastName,Phone,email from Lead where id not in :RepeatLead];
            if(RepeatLead!=null && !RepeatLead.isEmpty()){
          	list<lead> finalLead = new list<lead>();
			boolean flag;
            for (lead oblead :body)
            {
                flag = true;
               for (lead relead : RepeatLead)
               {
                
                if (oblead.lastname == relead.lastname && oblead.Email == relead.Email && oblead.Phone == relead.Phone && oblead.Company == relead.Company && oblead.Status == relead.Status )
                {
                    flag = false;
                    
                }
                    
                    
                }
                
                   if (flag==true){
                       
                     finalLead.add(oblead);  
                   }
                
            }
                insert finalLead;
                if (RepeatLead.size()> 0) 
                {
             	responseJSON.swraper(finalLead,'Succesfully Created',RepeatLead,'Lead already exists');
                }
                else
                {
                    responseJSON.swraper(finalLead,'Succesfully Created',RepeatLead,'Not Found');
                }
            }
            else
            {
                insert body;
                if (RepeatLead.size()> 0) 
                {
                 responseJSON.swraper(body,'Succesfully Created',RepeatLead,'Lead already exists');
                }
                else
                {
                    responseJSON.swraper(body,'Succesfully Created',RepeatLead,'Not Found');
                }
            }
            
            system.debug('===== RepeatLead' + RepeatLead);
            
        }
        catch(Exception exc){
            ///response.message='Mogamgo Dukhi Hua :('; 
            // objwraper.swraper(Leads,exc);
            
        }
        return responseJSON;
    }
    
    global class clswraper
    {
        public string Success_message {get;set;}
        public string UnSuccess_message {get;set;}
        public list<Lead> SuccesLead {get;set;}   
        public list<Lead> UnSuccessLead {get;set;}   
        public void  swraper(list<lead> lstSLead,string SUmsg,list<Lead> lstUNLead,String Unmessage)
        {
            Success_message = SUmsg;
            SuccesLead = lstSLead;
            UnSuccessLead = lstUNLead;
            UnSuccess_message = Unmessage;
        }
    }
   
}