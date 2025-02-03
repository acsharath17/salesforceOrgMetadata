import { LightningElement, track  } from 'lwc';
import getEmbeddingsFromOpenAI from '@salesforce/apex/AIQueryHandler.getEmbeddingsFromOpenAI';
import searchInPinecone from '@salesforce/apex/AIQueryHandler.searchInPinecone';
import getAnswerFromOpenAI from '@salesforce/apex/AIQueryHandler.getAnswerFromOpenAI';

export default class MyCustomPDFReader extends LightningElement {
    @track userQuery = '';
    @track finalAnswer = '';

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

            this.finalAnswer = answer;
            console.log('Final---'+this.finalAnswer);
        } catch (error) {
            console.error('Error processing user query:', error);
        }
    }
}