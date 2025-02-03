public class actionSupDemo {

    public PageReference HideUserName() 
    {
         name = 'RR';
        return null;
    }

    public String name { get; set; }

    public PageReference showUserName() 
    {
       
       name = UserInfo.getName();      
       return null;
    }  
    
      public String getName() 
      {
        return name;
      }     
}