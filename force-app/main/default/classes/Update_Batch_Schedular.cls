public class Update_Batch_Schedular implements Schedulable{
   public void execute(SchedulableContext sc) {
      
      Update_Batch  uab = new Update_Batch (); 
      database.executebatch(uab);
      
   }
}