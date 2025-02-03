import { LightningElement,api,track,wire } from 'lwc';
import markdownHtml from '@salesforce/apex/userStorySummary.metadataSummary';

export default class UserStoryDocument extends LightningElement {
    @api recordId;
    @track htmlContent;

    connectedCallback() {
        this.gethtmlConent(); // Call your function
    }

    async gethtmlConent(){
        try{
            console.log('record id--'+this.recordId);
            this.htmlContent = await markdownHtml({ recId: this.recordId });
            console.log('html--'+this.htmlContent);
            this.template.querySelector('div').innerHTML = this.htmlContent;
        }catch (error) {
            console.error('Error processing user query:', error);
        }        
    }
}