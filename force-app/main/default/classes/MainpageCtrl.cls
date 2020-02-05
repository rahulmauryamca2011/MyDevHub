public class MainpageCtrl {

    public MainpageCtrl(ApexPages.StandardController controller) {

    }
    
    public pagereference OpenPage()
    {
        pagereference  p = new pagereference('/apex/LightingPage?id=0017F000008brW7');
        p.setredirect(true);
        return p;
    }
        
}