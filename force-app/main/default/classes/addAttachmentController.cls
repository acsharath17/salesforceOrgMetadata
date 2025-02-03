public class addAttachmentController {
    
    public List<Contact> con {get; set;}
    public List<wrap> wList {get;set;}
    public blob att {get;set;}
    
    public addAttachmentController(){
        con = new List<Contact>();
        wList = new List<wrap>();
        con = [Select Id,Name from Contact Limit 5];
        for(Contact cc : con){
            blob abc;
            wList.add(new wrap(cc, abc)) ;   
        }
        
    }
    
    public void onSave(){
        List<Attachment> atmt = new list<Attachment>();
        List<contact> updatecon = new List<contact>();
        
        for(wrap w : wList){
            Attachment a = new Attachment();
            system.debug('At------------- '+w.at);
            if(w.at != null){
                a.body = w.at;
                a.ParentId = w.ct.Id;
                a.Name = 'test';
                atmt.add(a);
            }
        }
        insert atmt;
    }
    
    public class wrap{
        public contact ct {get;set;}
        public blob at{get;set;}
        
        public wrap(contact cont, blob b){
            ct = cont;
            at = b;
        }
    }
}