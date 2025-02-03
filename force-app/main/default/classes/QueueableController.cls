public with sharing class QueueableController {
    @AuraEnabled
    public static String enqueueJob(String recordId, string userQuery,string type) {
        createEmbeeding job = new createEmbeeding(userQuery,recordId,type);
        System.enqueueJob(job); // Enqueues the job and returns the Job ID
        return 'Job successfully enqueued';
    }
}