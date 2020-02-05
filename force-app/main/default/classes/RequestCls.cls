Public class RequestCls
{
    public string transactionId;
    public string erpCustomerNumber;
    
    public RequestCls()
    {
        transactionId='';
        erpCustomerNumber='';
    }
    public static RequestCls parse(String json) {
        return (RequestCls)System.JSON.deserialize(json, RequestCls.class);
        
    }

    public String serialize() {
        return JSON.serialize(this);
    }
}