public class Component_controller {

    public Component_controller() {

    }


    public Component_controller(ApexPages.StandardController controller) {

    }


    public LIst<Contact> getcon(){
        return [Select name,email from contact limit 10];
    }
}