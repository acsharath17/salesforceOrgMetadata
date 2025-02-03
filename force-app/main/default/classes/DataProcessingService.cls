public with sharing class DataProcessingService implements Queueable, Database.AllowsCallouts {
    public void execute(QueueableContext context) {
        try {
            // Step 1: Fetch Apex Classes
            System.debug('Step 1 - Getting Apex Classes');
            List<Map<String, Object>> apexClasses = ApexClassFetcher.fetchApexClasses();

            // Step 2: Create Data Chunks
            System.debug('Step 2 - Creating Data Chunks');
            Integer chunkSize = 1000;
            Integer overlapSize = 200;
            List<String> dataChunks = DataChunkCreator.createDataChunks(apexClasses, chunkSize, overlapSize);

            // Step 3: Create Embeddings
            System.debug('Step 3 - Creating embeddings for data chunks');
            List<Map<String, Object>> embeddings = OpenAIEmbeddingCreator.createEmbeddings(dataChunks);

            // Step 4: Upload Embeddings to Pinecone
            System.debug('Step 4 - Uploading embeddings to Pinecone');
            PineconeUploader.uploadEmbeddings(embeddings);

            System.debug('Process completed successfully');
        } catch (Exception e) {
            System.debug('Error during processing: ' + e.getMessage());
            // Handle exception as needed (e.g., send an email, create a log record)
        }
    }

    // Method to start the process
    public static void startProcessing() {
        System.enqueueJob(new DataProcessingService());
    }
}