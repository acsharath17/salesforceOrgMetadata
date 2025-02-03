public class theController {

    String searchText;
    List<Lead> results;

    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String s) {
        searchText = s;
    }

    public List<Lead> getResults() {
        return results;
    }
    
    public Account getAcc1(){
        Account a = Acc();
        return a;
    }

    public PageReference doSearch() {
        results = (List<Lead>)[FIND :searchText RETURNING Lead(Name, Email, Phone)][0];
        return null;
    }
    
    public Account Acc(){
        Account aa = new Account();
        aa.name = 'Inserted Account';
        insert aa;
        return aa;
    }
}