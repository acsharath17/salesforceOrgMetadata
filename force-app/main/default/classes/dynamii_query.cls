public class dynamii_query {
    
    public string fields{get;set;}
    public string qry {get;set;}
    
    public void query_fields(){
        
        
        qry = 'Select ';
        qry += fields+' '+'From Contact';
        
        List<Contact> cc = database.query(qry);
        
        system.debug('DDDDDDDDDDDDD'+cc);
        
        
    
    }
    
}