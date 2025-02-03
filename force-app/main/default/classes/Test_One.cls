public class Test_One {

    public LIst<Account> acc { get; set; }
    
    public Test_One(){
         
    }
    
    public void acc2(){
        acc = [Select id,name,phone FROM Account order by createddate limit 10];
    }
    
}