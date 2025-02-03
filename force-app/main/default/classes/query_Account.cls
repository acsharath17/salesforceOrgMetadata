public class query_Account {

    public query_Account(ApexPages.StandardSetController controller) {

    }
    
    public List<Account> getAcc(){
        list<Account> accn = [Select id,name,phone from Account Where phone != null limit 10];
        return accn;
    }

}