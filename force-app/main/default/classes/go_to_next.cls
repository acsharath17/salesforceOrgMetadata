public class go_to_next {

    public go_to_next(ApexPages.StandardController controller) {

    }
    
    public pagereference next(){
        pagereference pg = new pagereference('https://c.ap2.visual.force.com/apex/fieldset');
        return page.fieldset;
    }

}