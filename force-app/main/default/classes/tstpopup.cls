public class tstpopup {     

    public boolean displayPopup {get; set;}     
    
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    
    public List<Contact> getCon(){
        return [Select LastName from Contact Limit 5];
    }
    
  }