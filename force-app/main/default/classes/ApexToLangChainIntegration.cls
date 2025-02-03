public class ApexToLangChainIntegration {

    public static void processRecentApexClasses() {
        // Step 1: Get recent Apex class names and bodies from the Tooling API
        List<Map<String, String>> apexClasses = ToolingApiHelper.getRecentApexClassBodies();
        System.debug('Apex Class Bodies: ' + apexClasses);

        // Step 2: Call LangChain API to create chunks from the Apex class bodies
        if (apexClasses.size() > 0) {
            LangChainHelper.createChunksFromApexClassBodies(apexClasses);
        } else {
            System.debug('No Apex class bodies were retrieved.');
        }
    }
}