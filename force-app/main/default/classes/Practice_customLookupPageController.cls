public class Practice_customLookupPageController {
    public List<emailTemplateWrapper> recordsList{get;set;}
    public Practice_customLookupPageController (){
        recordsList=new List<emailTemplateWrapper>();
        recordsList.add(new emailTemplateWrapper(0));
        recordsList.add(new emailTemplateWrapper(1));
        recordsList.add(new emailTemplateWrapper(2));
    }
    public class emailTemplateWrapper{
       public String emailTemplateName{get;set;} 
       public String emailTemplateId{get;set;}
       public String frequency{get;set;}
       public integer counter{get;set;} //to store rowindex
       public emailTemplateWrapper( integer count){
           frequency='Weekly';
           counter=count;
       } 
    }
}