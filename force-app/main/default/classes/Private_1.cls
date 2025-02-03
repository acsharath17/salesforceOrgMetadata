public class Private_1 {
     integer ab(){
        system.debug('This is private Method');
        return 10;
    }
    
    public void xyz(){
    	integer i = ab();
        system.debug('Other Method');
    }
    
    public virtual class abc{
        protected void hi(){
            
        }
    }
}