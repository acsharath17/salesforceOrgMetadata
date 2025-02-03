import { LightningElement, track } from 'lwc';
import fetchApexClasses from '@salesforce/apex/ApexClassFetcher.fetchApexClasses';
import createDataChunks from '@salesforce/apex/DataChunkCreator.createDataChunks';
import createEmbeddings from '@salesforce/apex/OpenAIEmbeddingCreator.createEmbeddings';
import uploadEmbeddings from '@salesforce/apex/PineconeUploader.uploadEmbeddings';

export default class DataProcessingComponent extends LightningElement {
    @track processing = false;
    @track progressValue = 0;
    @track progressMessage = '';
    @track error;

    handleStart() {
        this.processing = true;
        this.progressValue = 0;
        this.progressMessage = 'Starting process...';
        this.error = null;

        this.processData(); // Start the data processing sequence
    }

    async processData() {
        try {
            // Step 1: Fetch Apex Classes
            this.progressMessage = 'Step 1 - Getting Apex Classes';
            const apexClasses = await fetchApexClasses();
            this.progressValue = 25;

            // Step 2: Create Data Chunks
            this.progressMessage = 'Step 2 - Creating Data Chunks';
            const chunkSize = 1000;
            const overlapSize = 200;
            const dataChunks = await createDataChunks({
                apexClasses: apexClasses,
                chunkSize: chunkSize,
                overlapSize: overlapSize,
            });
            this.progressValue = 50;

            // Step 3: Create Embeddings
            this.progressMessage = 'Step 3 - Creating embeddings for data chunks';
            const embeddings = await createEmbeddings({ dataChunks: dataChunks });
            this.progressValue = 75;

            // Step 4: Upload Embeddings to Pinecone
            this.progressMessage = 'Step 4 - Uploading embeddings to Pinecone';
            await uploadEmbeddings({ embeddings: embeddings });
            this.progressValue = 100;

            this.progressMessage = 'Process completed successfully';
            this.processing = false;
        } catch (error) {
            this.handleError(error);
        }
    }

    handleError(error) {
        this.error = error.body ? error.body.message : error.message;
        this.processing = false;
    }
}