public class Page_2 {
    
    public string hello{get;set;}
    
    public Page_2(ApexPages.StandardController controller) {
        hello = 'This is 2nd class contructor';
    }
    
    public string getex_text(){
        return 'aa';
    }

}