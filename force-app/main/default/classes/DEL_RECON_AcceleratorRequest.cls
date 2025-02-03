/**
* @author        Nancy Gupta / Apurva Agarwal 
* @date          16/06/2018
* @description   Class that handles the csv file upload and invokes the batch class to process it
* @name          DEL_RECON_AcceleratorRequestBatch 
*/

public class DEL_RECON_AcceleratorRequest{
    
    public Blob csvFileBody { get; set; }
    public String csvFileName { get; set; }
    public String csvNotSelectedError{ get; set; }
    public String csvNotSelectedSuccess{ get; set; }
    
    /*
    Method Name           : importCSVFile
    Method Description    : method reads a file that is selected by the user 
    						and invokes the batch method for further processing
    Input                 : NA
    Output                : PageReference             
    */
    public PageReference importCSVFile() {
        try{
            ID ReportID = ApexPages.currentPage().getParameters().get('id');
            if(csvFileBody!= Null){
                DEL_RECON_Accelerator__c rec = new DEL_RECON_Accelerator__c();
                rec.ID = ReportID;
                rec.Status__c = 'Submitted';
                if(rec != Null && rec.ID != Null){
                    update rec;
                }
                String csvBody = csvFileBody.toString();
                DEL_RECON_AcceleratorRequestBatch b = new DEL_RECON_AcceleratorRequestBatch(csvBody,ReportID,csvFileName); 
                Database.executebatch(b, 1);
                csvNotSelectedError ='';
                csvNotSelectedSuccess = 'Successfully uploaded. Please close the window.';
            }
            else{
                csvNotSelectedError = 'Please select a CSV file to proceed';
                csvNotSelectedSuccess = '';
            }
        }
        catch(exception e){
            csvNotSelectedError = e.getMessage();
        }
        return null;
    }
}