public class controller_one {
    
    public integer a = 0;
    
    public controller_one(){
        SYSTEM.DEBUG('CONTROLLER ONE CONSTRUVTOR');
    }
    
    public controller_one(string ab){
    
    }
    
    public void ab(){
        a = 20;
        SYSTEM.DEBUG('CONTROLLER ONE VOID METHOD');
    }
    
    public integer bc(){
        return 30;
    }
}