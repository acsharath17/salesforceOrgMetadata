public class Wizard {
    
    public string selected_value{get;set;}
    public string ab;
    
    public list<selectoption> getSel_type(){
        list<selectoption> opt = new list<selectoption>();
        opt.add(new Selectoption('--None--','--None--'));
        opt.add(new Selectoption('School','School'));
        opt.add(new Selectoption('College','College'));
        return opt;
    
    }
    
    public pagereference school(){
    
        return page.student;
    }
    
    public pagereference college(){
        pagereference pp = new pagereference('https://c.ap2.visual.force.com/apex/student');
        //return page.college_student;
        return pp;
    }
    
    public pagereference go_back(){
    
        return page.master_page;
    }
    
    public pagereference call_page(){
    system.debug('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSS'+selected_value);
        if(selected_value == 'School'){
            ab = 'student';
        }
        
        if(Selected_value == 'College'){
            ab = 'College_Student';
        }
        
        return new pagereference('https://c.ap2.visual.force.com/apex/'+ab);
    }
    
}