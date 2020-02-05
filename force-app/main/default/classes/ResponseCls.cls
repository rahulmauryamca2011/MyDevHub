Public class ResponseCls
{
    public Child creditCheckResponse = new Child();
    
    
    public class Child
    {
        public string transactionId;
        public string status;
        public string creditHold;
        public Child()
        {
            transactionId='';
            status='';
            creditHold ='';
        }
       
    }
}