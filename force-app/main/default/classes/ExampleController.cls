public class ExampleController {
      
      Public transient  DateTime t1;
      public   DateTime t2;
      
    public String getT1() {
    
    if (t1 == null) t1 = System.now();
    return '' + t1;
    }
    public  String getT2() {
    
    //a = System.now()+1;
    if (t2 == null) t2 = System.now();
    return '' + t2;
    }
}