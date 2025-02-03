public class Custom_comp {

    public List<Contact> getAll_con(){
        List<Contact> con = [Select id,name,email,phone from contact Limit 5];
        return con;
    }

}