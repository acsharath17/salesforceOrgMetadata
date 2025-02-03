public class test_wrapper {

    public test_wrapper(ApexPages.StandardController controller) {
        acc_list = new List<acc_wrap>();
        
        for(Account aa : [Select id,name,type,industry from Account Limit 5]){
            
            acc_list.add(new acc_wrap(aa));
            
        }
    }

    
    public list<acc_wrap> acc_list{get;set;}
    
    
    public list<Account> selected_acc{get;set;}
    
    public void sel_acc(){
        
        selected_acc = new List<Account>();
        for(acc_wrap e : acc_List){
            if(e.selected == true)
            selected_acc.add(e.acc);
        }
        
    }
    
    public List<Account> getall_account(){
        list<Account> acc = [Select name,phone from Account limit 5];
        return acc;
    }
    
    public class acc_wrap{
        
        public boolean selected{get;set;}
        public account acc{get;set;}
        
        public acc_wrap(Account a){
            acc = a;
            selected = false;
        }
    }

}