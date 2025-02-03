public class Evening_Day_3 {
	
    public Evening_Day_3(){ //Constructor Method because class name and method name are same
    	system.debug('Constructor Method');    
    }
	
    public void one(){ //this method will not return anything
    	system.debug('Void Method');    
    }
	
    public integer two(){
        integer a = 10;
        integer b = 20;
        integer c = a*b;
        system.debug('This method is being called in method three');
        return c;
    }

    public void three(){
        integer d = two();
        system.debug('Value of d '+d);
    }	
    
}