public with sharing class PagingController_3 {

    List<categoryWrapper> categories {get;set;}
    
    public string con_id;
    public boolean go ;
    
    public boolean getbutton(){
        go = true;
        return go;
    }
    
    public string a{get;set;}
    public string b;
    public string qry;

    // instantiate the StandardSetController from a query locator
    public ApexPages.StandardSetController con {
        get {
            system.debug('%%%%%%%%%%%%%%%%% '+con);
            system.debug('Nooooooooooooooooo');
            if(con == null) {
                system.debug('@@@@@@@@@@@@@@@@@@@@@@ '+a);
                qry = 'Select id,name From Contact Where name != null';
                
                if(a != null && a != ''){
                    qry += ' and name =: a';
                }
                
                con = new ApexPages.StandardSetController(Database.getQueryLocator(qry));
                // sets the number of records in each page set
                system.debug('DDDDDDDDDDDDDDDDDDDDDDDD '+b);
                con.setPageSize(5);
            }
            return con;
        }
        set{
            b = a;
            system.debug('HHHHHHHHHHHHHHHHHHHHHHHHH');
        }
    }

    // returns a list of wrapper objects for the sObjects in the current page set
    public List<categoryWrapper> getCategories() {
        categories = new List<categoryWrapper>();
        for (Contact category : (List<Contact>)con.getRecords())
            categories.add(new CategoryWrapper(category));

        return categories;
    }
    
    public List<Contact> getcons(){
        system.debug('AAAAAAAAAAAAAAAAAAA');
        system.debug('SSSSSSSSSSSSSSSSSSS'+a);
        system.debug('VVVVVVVVVVVVVVVVVVV'+con.getRecords());
        List<Contact> cc = con.getRecords();
        system.debug('BBBBBBBBBBBBBBBB'+cc.size());
        return cc;
    }

    // displays the selected items
     public PageReference process() {
         system.debug('!!!!!!!!!!!!!!!! '+con);
         con = null;
         system.debug('$$$$$$$$$$$$$$$$ '+con);
         getcons();
         return null;
     }

    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }

    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }

    // returns the first page of records
     public void first() {
         con.first();
     }
     
     public pagereference rec_page(){
         system.debug('FFFFFFFFFFFFFFFFFFFFF');
         con_id = ApexPages.currentPage().getParameters().get('cid');
         system.debug('AAAAAAAAAAAAAAAAAAAAAA'+con_id);
         go = false;
         return null;
     }
     
     public pagereference goto(){
         return new pagereference('/'+con_id);
     }

     // returns the last page of records
     public void last() {
         con.last();
     }

     // returns the previous page of records
     public void previous() {
         con.previous();
     }

     // returns the next page of records
     public void next() {
         con.next();
     }

     // returns the PageReference of the original page, if known, or the home page.
     public void cancel() {
         con.cancel();
     }

}