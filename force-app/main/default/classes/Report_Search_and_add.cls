public class Report_Search_and_add {

    
    public Report[] Available_Reports {get;set;}
    public Reports_Sceduled__c[] Selected_Reports {get;set;}
    public String toSelect {get; set;}
    public String toUnselect {get; set;}
    public id parentId;
    public String qString;
    public string selected_folder_name{get;set;}
    public string searchString{get;set;}
    public string email_add{get;set;}
    
    public Reports_Sceduled__c[] forDeletion = new Reports_Sceduled__c[]{};
    public Reports_Sceduled__c[] forAddition = new Reports_Sceduled__c[]{};
    
    ApexPages.StandardController GstdController1; 
    
    public Schedule_Report__c sch_rep {get;set;}
    
    public id rep_sch_id;
    
    public SelectOption[] selectedUsers { get; set; }
    public SelectOption[] allUsers { get; set; }
    
    public String message { get; set; }
    
    
    
    public Report_Search_and_add(ApexPages.StandardController sscontroller) {
        
        selectedUsers = new List<SelectOption>();
        List<User> users = [Select id,name,email from User];
        
        allUsers = new List<SelectOption>();
        
        for(User u : users){
            allUsers.add(new selectoption(u.id,u.name));
        }
        
        GstdController1 = ssController;
        parentId = Apexpages.CurrentPage().getParameters().get('id');
        string qry = 'Select id,name,Report_Folder__c,Report_Name__c,Report_Id__c  From Reports_Sceduled__c Where Name != null ';
        
        
            qry += ' and Scheduler__c =: parentId';
        
        
        Selected_Reports = database.query(qry);
    }
    
    public void update_available_report(){
        
        qString = 'Select id,name,FolderName From Report Where id != null ';
        
        if(selected_folder_name != null){
        qString += ' and FolderName =: selected_folder_name';
        }
        
        if(searchString!=null){        
            qString+= ' AND Name like \'%' + searchString + '%\'';
            System.debug('aaaaaaaaaaaaaaaaaaaaaaaa'+searchString);
        }
        
        Set<ID> selectedEntries = new Set<ID>();
        
        for(Reports_Sceduled__c d:Selected_Reports){       
            selectedEntries.add(d.Report_Id__c);
        }
        
        if(selectedEntries.size()>0){
            String tempFilter = ' and Id not in (';
            for(Id i : selectedEntries){
                tempFilter+= '\'' + (String)i + '\',';
            }
            String extraFilter = tempFilter.substring(0,tempFilter.length()-1);
            extraFilter+= ')';            
            qString+= extraFilter;
        }
        
        qString+= ' order by Name';
        Available_Reports = database.query(qString); 
        
    }
    
    public void add_to_selected(){
        string sch;
        
        for(Report rr : Available_Reports){
            if((String)rr.Id==toSelect){
                Selected_Reports.add(new Reports_Sceduled__c(Report_Folder__c = rr.FolderName, Report_Id__c = rr.id, Report_Name__c = rr.Name ) );
                break;
            }
        }
        
        update_available_report();
    }
    
    public pagereference remove_selected(){
        Integer count = 0;
        for(Reports_Sceduled__c RS : Selected_Reports){
            if((string)RS.Report_id__c == toUnselect){
                if(RS.id != null)
                forDeletion.add(RS);
                
                Selected_Reports.remove(count);
                break;
                
            }
            count ++;
        }
        update_available_report();
        return null;
    }
    
    public List<SelectOption> getFolder_name(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--None--'));
        
        for(Folder ff : [Select id,name From Folder Where Name!= null and Type = 'Report' ]){
            //string ab = ff.name;
            if(ff.name != null)
            options.add(new SelectOption(ff.name,ff.name));
        }
        return options;
    }
    
    public pagereference onSave(){
        
        system.debug('VVVVVVVVVVVVVVVVVVVVVVVVVVVVV '+forDeletion.size());
        datetime from_d;
        datetime to_d;
        
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ '+selectedUsers);
        
        if(forDeletion.size()>0)
            delete(forDeletion);

        list<Reports_Sceduled__c> ss = new list<Reports_Sceduled__c>();
        
        list<Schedule_Report__c> rep = [Select Email_Addresses__c From Schedule_Report__c WHERE id =: rep_sch_id limit 1];
        rep[0].Email_Addresses__c = email_add;
        update rep[0];
        
        list<Users_Receving__c> UR = new List<Users_Receving__c>();
        for ( SelectOption so : selectedUsers ){
            Users_Receving__c USR = new Users_Receving__c();
            USR.User__c = so.getValue();
            USR.Scheduler__c = rep_sch_id;
            UR.add(USR);
        }
        
        insert UR;
        
        
        for(Reports_Sceduled__c rs : Selected_Reports ){
            rs.Scheduler__c = rep_sch_id;
            ss.add(rs);    
        }
        system.debug('BBBBBBBBBBBBBBBBBBBBBBBBB '+ss.size());
        
        if(ss.size() > 0)
        upsert(ss);
        /*try{
            if(ss.size() > 0)
            upsert(ss);
        }catch(Exception e){
            ApexPages.addMessages(e);
            system.debug('AAAAAAAAAAAAAAAAAAAAAA '+e.getMessage());
            return null;       
        }*/
        
        return new Pagereference('/'+rep_sch_id);    
    
    }
    
    public pagereference onCancel(){
        return null;
    }
    
    public pagereference go_next(){
        PageReference pr = GstdController1.save();
        pageReference pv = GstdController1.view();
        Schedule_Report__c SR = (Schedule_Report__c)GstdController1.getRecord();
        rep_sch_id = SR.id;
        return page.select_Time_and_User;
    }
    
    public pagereference go_back(){
        return page.Schedule_report;
    }
    
    public PageReference save_new() {
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

}