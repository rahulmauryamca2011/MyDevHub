global class myHandler implements Messaging.InboundEmailHandler {
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          
          system.debug('code pass from here==');
          if (email.subject != Null)
          {
              
              Case Cs = new Case();
              Cs.contactid = (email.subject);
              Cs.Status = 'New'; 
              cs.Origin= 'Email';
              insert Cs;
          system.debug('code pass from here==' + Cs);
          
              emailmessage em = new emailmessage();
              
              em.parentID = Cs.id;
              //em.ToAddress = email.ToAddresses;
             // em.BccAddress= email.BccAddress;
             // em.CcAddress = email.ccAddresses;
             em.fromaddress = email.fromaddress;
              em.subject = email.subject;
              em.TextBody = email.plainTextBody;
              insert em;
         
         system.debug('code pass from here==' + email.binaryAttachments);
                  
         if(email.textAttachments != null)
        {
        system.debug('code pass from here text attachment ==');
          for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
          Attachment attachment = new Attachment();
          
          attachment.Name = tAttachment.fileName;
          attachment.Body = Blob.valueOf(tAttachment.body);
          attachment.ParentId = em.Id;
          insert attachment;
        }

        }
        
            //Save any Binary Attachment
         if(email.binaryAttachments != null)
        {
system.debug('code pass from here binary attachment ==');
            for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
            system.debug('code pass from start atachment==' + em.ID);
            Attachment attachment = new Attachment();
            attachment.Name = bAttachment.fileName;
            attachment.Body = bAttachment.body;
            attachment.ParentId = em.Id;
            insert attachment;


            }
        } 
         
              
       }  
          
    
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.toAddresses= new String[] {'rahulmaurya227121988@gmail.com'};
        mail.subject = 'Case Created';
        mail.plainTextBody = 'Test email for case creation';     
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
          
          return result;
      }
  }