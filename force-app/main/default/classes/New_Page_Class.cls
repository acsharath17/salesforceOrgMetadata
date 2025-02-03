public class New_Page_Class {
    
    public string con_id;
    public boolean go ;
    
    public boolean getbutton(){
        go = true;
        return go;
    }
    
    public pagereference rec_page(){
         system.debug('FFFFFFFFFFFFFFFFFFFFF');
         con_id = ApexPages.currentPage().getParameters().get('cid');
         system.debug('AAAAAAAAAAAAAAAAAAAAAA'+con_id);
         go = false;
         return null;
     }
     
     public pagereference Amend(){
         return new pagereference('/apex/pagination_test_2/?id='+con_id);
     }
    
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Id, Name,email FROM Contact Order By Name limit 100]));
                // sets the number of records in each page set
                con.setPageSize(10);
            }
            return con;
        }
        set;
    }
    
    public List<Contact> getall_con(){
        List<Contact> cc = con.getRecords();
        return cc;
    }
    
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
    
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
    
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
    
    public void first() {
         con.first();
     }
     
    public void last() {
         con.last();
     }
     
     public void previous() {
         con.previous();
     }
     
     public void next() {
         con.next();
     }
     
     public void cancel() {
         con.cancel();
     } 
}