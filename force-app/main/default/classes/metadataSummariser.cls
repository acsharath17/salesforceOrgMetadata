public with sharing class metadataSummariser {
    @AuraEnabled(cacheable=true)
       public static map<String,String> getAllApexClasses() {
            map<String,String> apexClassNames = new map<String,String>();
           for(ApexClass ac : [SELECT Name, Body FROM ApexClass limit 100]) {
               apexClassNames.put(ac.Name,ac.Body);
           }
           return apexClassNames;
       }
}