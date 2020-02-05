public class clsDMLonACC {
    
    public void updateaccount()
    {
        
       list<Account> lstacc = [select name,Phone from account limit 1];
        if(lstacc!=null && !lstacc.isEmpty())
        {
            for (account a : lstacc)
            {
            	a.phone = a.phone + 1;    
            }
        }
        
        update lstacc;
    }

}