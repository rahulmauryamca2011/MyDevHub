@istest(seeAllData = false)
public class accconhierarchyTest
{
    private static Account acc;
    
    public static testmethod void Method()
    {
        acc = new Account();
        acc.Name='test';
        insert acc;
        
        accconhierarchy ob = new accconhierarchy();
    }
}