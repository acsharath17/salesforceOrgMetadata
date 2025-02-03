import {  LightningElement,api,track,wire } from 'lwc';
import { getRecord } from "lightning/uiRecordApi";
import markdownHtml from '@salesforce/apex/markdownDataConverter.markdownHtml';
const FIELDS = ["User_Story__c.Requirement__c", "User_Story__c.Technical_Solution__c"];

export default class CreateTechnicalSolution_View extends LightningElement {
    @api recordId;
    @api objectApiName;
    acceptanceCriteria;
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
            this.userRecord = data;
            this.acceptanceCriteria = this.userRecord.fields.Technical_Solution__c.value;
            console.log('record data----'+this.acceptanceCriteria);
            this.gethtmlConent();
        }
    }

    async gethtmlConent(){
        try{
            this.htmlContent = await markdownHtml({ markdownContent: this.acceptanceCriteria });
            console.log('html content--'+this.htmlContent);
            this.template.querySelector('div').innerHTML = this.htmlContent;
        }catch (error) {
            console.error('Error processing user query:', error);
        }
        
    }
}