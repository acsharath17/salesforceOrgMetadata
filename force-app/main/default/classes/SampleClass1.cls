public class SampleClass1 {
    public string msg1;
    
    
    public Pagereference gotonewpage()
{     
     system.debug('msg1------------->'+msg1);
     PageReference pageRef = Page.SamplePage2;
     pageRef.getParameters().put('msg','success');
     return null;
}
}