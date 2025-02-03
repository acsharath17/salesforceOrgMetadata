import { LightningElement, api } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import MARKED_JS from '@salesforce/resourceUrl/marked';
import marked from '@salesforce/resourceUrl/marked'; 

export default class MarkdownPreview extends LightningElement {
    isRendered = false;
    _body = '';
    @api
    get body() {
        return this._body;
    }
    set body(value) {
        this._body = value;

        if (this.isRendered) {
            this.renderMarkdown();
        }
    }

    renderedCallback() {
        if (this.isRendered) {
            return;
        }

        this.isRendered = true;

        loadScript(this, marked).then(() => {
            // script has loaded
            console.log('marked.js loaded successfully'); 
            this.renderMarkdown();
        });
        
    }
    renderMarkdown() {
        this.template.querySelector('div').innerHTML = '<p>The custom fields defined on the <code>Book__c</code> object are:</p><ol><li><code>Total_Books__c</code></li><li><code>Number_Of_Books__c</code></li><li><code>Student__c</code></li><li><code>Price__c</code></li><li><code>Publisher_Id__c</code></li></ol><p>These fields are indicated in the XML metadata and the field permissions sections provided in the context.</p>';
    }
}