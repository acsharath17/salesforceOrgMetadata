trigger Create_Duplicate on QuoteLineItem (after insert,after update) {
    
    if(Trigger.isInsert){
        Submit_ForApproval SF = new Submit_ForApproval();
        SF.submit(trigger.new);
    }
    
}