@isTest
global class ParkServiceMock  implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        string[] abc = new string[]{'Park1','Park2','Park3'};
        ParkService.byCountryResponse response_x = 
            new ParkService.byCountryResponse();
        response_x.return_x = abc;
        // end
        response.put('response_x', response_x); 
   }
}