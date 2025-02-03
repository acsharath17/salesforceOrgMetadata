public with sharing class DataChunkCreator {
    @AuraEnabled
    public static List<String> createDataChunks(List<Map<String, Object>> apexClasses, Integer chunkSize, Integer overlapSize) {
        String allCode = '';
        for (Map<String, Object> apexClass : apexClasses) {
            String body = (String) apexClass.get('Body');
            allCode += body + '\n';
        }

        List<String> chunks = new List<String>();
        Integer textLength = allCode.length();
        Integer start = 0;

        while (start < textLength) {
            Integer end1 = Math.min(start + chunkSize, textLength);
            String chunk = allCode.substring(start, end1);
            chunks.add(chunk);
            start = end1 - overlapSize;
            if (start < 0) {
                start = 0;
            }
        }
        return chunks;
    }
}