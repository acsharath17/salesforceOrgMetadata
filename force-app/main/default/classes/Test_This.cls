public class Test_This {
    public string s1 = 'hi';
    public integer b;
    
    public Test_this(integer a){
        system.debug('test constructor chaining');
    }
    public Test_This(string s2){
        this(6);
        system.debug(s1);
       system.debug(s2); 
       this.s1 = s2;
        
    }
    
    public Test_This(){
        this('constructor chaining');
        system.debug('**************'+s1);
        
    }
}