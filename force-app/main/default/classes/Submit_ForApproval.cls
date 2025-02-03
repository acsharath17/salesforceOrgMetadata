public class Submit_ForApproval {
	
    public void submit(List<QuoteLineItem> Quo){
        List<Quote_Line__c> QL = new List<Quote_Line__c>();
        for(QuoteLineItem qq : Quo){
            Quote_Line__c q = new Quote_Line__c();
            q.Total_Price__c = qq.TotalPrice;
            q.Quote_Name__c = qq.QuoteId;
            q.Discount__c = qq.Discount;
            q.Line_Item_Description__c = qq.Description;
            
            q.Quote_Line_Item__c = qq.id;
            q.Name = qq.LineNumber;
            q.Product__c = qq.Product2Id;
            //q.ProductCode__c = qq.
            q.Quantity__c = qq.Quantity;
            q.Sales_Price__c = qq.UnitPrice;
            q.Subtotal__c = qq.Subtotal;
            q.ServiceDate__c = qq.ServiceDate;
            QL.add(q);
        }
        Insert QL;
    }
}