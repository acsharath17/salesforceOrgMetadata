public class custom_Save{
    public pagereference re_direct(){
        pagereference p = new pagereference('https://c.ap2.visual.force.com/apex/mass_update');
        p.setredirect(true);
        return p;
    }
}