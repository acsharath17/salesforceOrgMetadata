public class update_Accounts {
	LIst<Account> a = new List<Account>();
    LIst<Account> up_acc = new List<Account>();
    public void acc(){
        a = [Select phone from Account];
        
       /* for(integer i =0 ; i < a.size() ; i++){
        	a[i].phone = '9986081700';
            //update a[i];
            up_acc.add(a[i]);
        }
        update up_acc;*/
        
        for(Account aa : a){
         	aa.phone = '9986081766';
            up_acc.add(aa);
        }
        update up_acc;
        
    }
    
}