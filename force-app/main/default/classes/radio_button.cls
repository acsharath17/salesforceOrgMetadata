public class radio_button {
    public string val{get;set;}
    public string val1{get;set;}
    public boolean access1{get;set;}
    public boolean access2{get;set;}
    
    public radio_button(){
        access1 = false;
        access2 = true;
    }
    
    public void submit(){
        system.debug('DDDDDDDDDDDDDD '+val);
        system.debug('EEEEEEEEEEEEEE '+val1);
    }
    
    
}