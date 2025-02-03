public class StreamingAPIController  
{  
    //Everytime page is reRendered it will get refreshed values of account  
    public List<Account> getRefreshedAccount  
    {  
        get  
        {  
            return [select Id, Name from Account LIMIT 50000] ;  
        }  
        set;  
    }  
      
    public StreamingAPIController()  
    {  
    }  
}