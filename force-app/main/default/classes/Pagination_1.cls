public class Pagination_1 {

    public ApexPages.StandardSetController acc{
        get{
            if(acc == null){
                acc = new ApexPages.StandardSetController(Database.getQueryLocator([Select id,name,Website From Account Order By Name Limit 100]));
                acc.setPageSize(10);
            }
        return acc;
        }
        set;
    }
    
    public List<Account> getall_con(){
    
        list<Account> aa = acc.getRecords();
        
        return aa;
    }
    
    public boolean an {get;set;}
    
    
   
    
    public boolean hasNext{
        get{
            return acc.gethasNext();
        }
        set;
    }
    
    public boolean hasPrevious{
        get{
            return acc.getHasPrevious();
        }
        set;
    
    }
    
    public integer pagenumber{
        get{
            return acc.getPageNumber();
        }
        set;
    }
    
    public void first(){
        acc.first();
    }
    
    public void last(){
        an = acc.getHasNext();
        acc.last();
    }
    
    public void next(){
        acc.next();
    }
    
    public void previous(){
        acc.previous();
    }

}