public class actionpollerDemoController1 {
public  Integer seconds{get;set;}
  public actionpollerDemoController1(){
   seconds = 0;
  }
 
  public void callMethod(){
    seconds = seconds + 10;
  }
}