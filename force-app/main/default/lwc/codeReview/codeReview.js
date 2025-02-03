import { LightningElement,api,track,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import getEmbeddingsFromOpenAI from '@salesforce/apex/AIQueryHandler.getEmbeddingsFromOpenAI';
import searchInPinecone from '@salesforce/apex/AIQueryHandler.searchInPinecone';
import getAnswerFromOpenAI from '@salesforce/apex/AIQueryHandler.getAnswerFromOpenAI';
import getAnswerFromOpenAI2 from '@salesforce/apex/AIQueryHandler.getAnswerFromOpenAI2';
import openAiAnswer from '@salesforce/apex/QueueableController.enqueueJob';
import apexJobStatus from '@salesforce/apex/aiPrompts.checkJobStatus';
import { getRecord } from "lightning/uiRecordApi";
const FIELDS = ["Metadata__c.Name", "Metadata__c.Metadata_Type__c","Metadata__c.Code_Review_Summary__c"];

export default class CodeReview extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track hideRequirement = true;
    @track isShowModal = false;
    @track userQuery = '';
    @track finalAnswer = '';
    metadataRecord;
    metadataDataName;
    metadataType;
    changeSummary;

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
            this.metadataDataName = this.metadataRecord.fields.Name.value;
            this.metadataType = this.metadataRecord.fields.Metadata_Type__c.value;
            this.changeSummary = this.metadataRecord.fields.Code_Review_Summary__c.values;
            this.userQuery = 'Metadata Name : '+this.metadataDataName+'\n Metadata Type: '+this.metadataType;
        }
    }

    
    handleSuccess(e) {
        // Close the modal window and display a success toast
        this.dispatchEvent(new CloseActionScreenEvent());
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Opportunity Record Updated!',
                variant: 'success'
            })
        );
    }
    closeModal(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handleInputChange(event) {
        this.userQuery = event.target.value;
    }

    async handleSubmit() {
        try {
            // Step 1: Generate embeddings from OpenAI
            const embeddings = await getEmbeddingsFromOpenAI({ inputText: this.userQuery });

            // Step 2: Search in Pinecone using the embeddings
            const pineconeResults = await searchInPinecone({ embeddings: embeddings });

            // Step 3: Get a tailored answer from OpenAI
            const answer = await getAnswerFromOpenAI({
                userQuery: this.userQuery,
                context: pineconeResults
            });

            /*const answer2 = await getAnswerFromOpenAI2({
                userQuery: this.userQuery
            });*/

            this.finalAnswer = answer;
            console.log('Final---'+this.finalAnswer);
            
        } catch (error) {
            console.error('Error processing user query:', error);
        }
    }
    handleSubmitv2(){
        console.log('new method being called--'+this.recordId);

        openAiAnswer({userQuery:this.userQuery,recordId: this.recordId,type:'Code Review'})
    }

    async handleButtonClick() {
        //try {
            const jobId='test';  
            this.isShowModal = true;  
        // Call the Apex method to invoke the Queueable job
            console.log('user query---'+this.userQuery);
            await openAiAnswer({userQuery:this.userQuery,recordId: this.recordId, type:'Code Review'});
            
            // Show toast message that job has started
            this.showToast('Info', 'Processing started. Please wait...', 'info');

            // Polling logic to check job status
            let isJobComplete = false;
            const pollInterval = 2000; // Poll every 2 seconds
            while (!isJobComplete) {
                console.log('checking job complete--'+isJobComplete);
                isJobComplete = await this.checkJobStatus();
                if (!isJobComplete) {
                    await this.delay(pollInterval);
                }
            }

            // Show success message
            this.showToast('Success', 'Processing complete!', 'success');

            // Refresh the page
            this.reloadPage();

       // } catch (error) {
            // Handle error and show an error toast
        //    this.showToast('Error', 'An error occurred: ' + error.body.message, 'error');
        //}
    }

    // Helper method to check the status of the Queueable job
    async checkJobStatus() {
        console.log('check status called---');
        // Add Apex method to check job status
        const status = await apexJobStatus({ }); // Assume this returns true if the job is complete
        console.log('Status----'+status);
        return status;
    }

    // Utility method to delay execution
    delay(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    // Utility method to reload the page
    reloadPage() {
        //window.location.reload();
        this.isShowModal = false;
        this.hideRequirement = false;
    }

    // Utility method to show toast notifications
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}