import {  LightningElement,api,track,wire } from 'lwc';
import { getRecord } from "lightning/uiRecordApi";
import markdownHtml from '@salesforce/apex/markdownDataConverter.markdownHtml';
const FIELDS = ["Metadata__c.Code_Review_Summary__c", "Metadata__c.Name"];

export default class CodeReview_View extends LightningElement {
    @api recordId;
    @api objectApiName;
    codeReviewSummary;
    @track htmlContent;

    @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
    wiredRecord({ error, data }) {
        if (error) {
        let message = "Unknown error";
        if (Array.isArray(error.body)) {
            message = error.body.map((e) => e.message).join(", ");
        } else if (typeof error.body.message === "string") {
            message = error.body.message;
        }
        this.dispatchEvent(
            new ShowToastEvent({
            title: "Error loading contact",
            message,
            variant: "error",
            }),
        );
        } else if (data) {
            this.metadataRecord = data;
            this.codeReviewSummary = this.metadataRecord.fields.Code_Review_Summary__c.value;
            console.log('record data----'+this.codeReviewSummary);
            this.gethtmlConent();
        }
    }

    async gethtmlConent(){
        try{
            this.htmlContent = await markdownHtml({ markdownContent: this.codeReviewSummary });
            console.log('html content--'+this.htmlContent);
            this.template.querySelector('div').innerHTML = this.htmlContent;
        }catch (error) {
            console.error('Error processing user query:', error);
        }
        
    }    
}