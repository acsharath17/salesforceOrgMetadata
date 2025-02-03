public virtual class Extended_class_v1 {
	
    public string a;
    public string xyz(){
        system.debug('This is virtual class method');
        return null;
    }
    
    public virtual integer  abc( integer a, integer b){
        
        integer c = a * b;
		system.debug('Multiplication '+c);        
        return c;
        
    }
    
}