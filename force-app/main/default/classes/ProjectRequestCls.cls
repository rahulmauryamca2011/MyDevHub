public class ProjectRequestCls
{
    public string transactionId;
    public list<projectsCls> projects = new list<projectsCls>();
    public class projectsCls
    {
        public string projectDesc;
        public string projectNbr;
        public string taskNbr;
        public string taskName;
        public string projectStatus;
        public string chargeableFlag;
    }
}