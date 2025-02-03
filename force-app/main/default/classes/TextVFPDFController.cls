public class TextVFPDFController {
    public Opportunity opp{get;set;}
    public TextVFPDFController(){
        Id oppId = apexpages.currentpage().getparameters().get('id');
        opp = [select id,Name from opportunity where id=: oppId];
    }
}