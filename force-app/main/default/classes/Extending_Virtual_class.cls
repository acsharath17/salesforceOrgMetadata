public class Extending_Virtual_class Extends Extended_class_v1 {
    
    public override integer abc(integer a,integer b){
        integer d = super.abc(a,b);
        integer c = a + b + d;
        system.debug('Addition '+c);
        return c;
    }
    
}