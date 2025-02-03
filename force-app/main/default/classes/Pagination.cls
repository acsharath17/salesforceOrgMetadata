public class Pagination
{
    private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize = 5;
    public string filter {get;set;}
    
    public Pagination()
    {
        totalRecs = [select count() from account];
    }
    
    public List<account> getacclist()
    {
        string qry = 'SELECT id,Name, website, AnnualRevenue, description, Type FROM account WHERE Name != Null';
        
        if(filter != null && filter != ''){
            qry += ' and Name =: filter';
        }
        
        qry += ' LIMIT :LimitSize OFFSET :OffsetSize';
        
        //List<account> acc = Database.Query('SELECT Name, website, AnnualRevenue, description, Type FROM account LIMIT :LimitSize OFFSET :OffsetSize');
        List<account> acc = Database.Query(qry);
        System.debug('Values are ' + acc);
        return acc;
    }
    
    public string con_id;
    
    public pagereference rec_page(){
         system.debug('FFFFFFFFFFFFFFFFFFFFF');
         con_id = ApexPages.currentPage().getParameters().get('cid');
         system.debug('AAAAAAAAAAAAAAAAAAAAAA'+con_id);
         //go = false;
         return null;
     }
     
    public pagereference goto(){
        return new pagereference('/'+con_id);
    }
    
    public void search(){
        getacclist();    
    }
    
    public void FirstPage()
    {
        OffsetSize = 0;
    }
    
    public void previous()
    {
        OffsetSize = OffsetSize - LimitSize;
    }
    
    public void next()
    {
        OffsetSize = OffsetSize + LimitSize;
    }
    
    public void LastPage()
    {
        OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
    }
    
    public boolean getprev()
    {
        if(OffsetSize == 0)
        return true;
        else
        return false;
    }
    
    public boolean getnxt()
    {
        if((OffsetSize + LimitSize) > totalRecs)
        return true;
        else
        return false;
    }
}