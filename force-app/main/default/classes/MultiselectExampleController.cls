public with sharing class MultiselectExampleController {

    public SelectOption[] selectedContacts { get; set; }
    public SelectOption[] allContacts { get; set; }
    
    public SelectOption[] selectedUsers { get; set; }
    public SelectOption[] allUsers { get; set; }
    
    public String message { get; set; }
    
    public MultiselectExampleController() {
        selectedContacts = new List<SelectOption>();
        selectedUsers = new List<SelectOption>();
        
        List<Contact> contacts = [SELECT Name, Id FROM Contact];
        List<User> users = [Select name,id from User];
        
        allUsers = new List<SelectOption>();    
        allContacts = new List<SelectOption>();
        
        for ( Contact c : contacts ) {
            allContacts.add(new SelectOption(c.Id, c.Name));
        }
        
        for(User u : users){
            allUsers.add(new selectoption(u.id,u.name));
        }
        
    }

    public PageReference save() {
        message = 'Selected Contacts: ';
        Boolean first = true;
        for ( SelectOption so : selectedUsers ) {
            if (!first) {
                message += ', ';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            first = false;
        }
        
        return null;       
    }
    
    public PageReference save_new() {
        message = 'Selected Contacts: ';
        Boolean first = true;
        for ( SelectOption so : selectedContacts ) {
            if (!first) {
                message += ', ';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            first = false;
        }
        
        return null;       
    }
}