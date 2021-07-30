@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    private static final String REQUEST_PARAMS_FUZZYNAME = 'fuzzyname';
    private static final String REQUEST_PARAMS_AGE = 'age';
    
    @HttpGet
    global static void getTourists() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        Map<String, String> paramsMap = request.params;
        String touristName = paramsMap.get(REQUEST_PARAMS_FUZZYNAME);
        String touristAge = paramsMap.get(REQUEST_PARAMS_AGE);
        if (String.isEmpty(touristAge)) {
            List<Tourist__c> resultWithoutAge = TouristManager.getByNameSOSL(touristName);
            response.responseBody = Blob.valueOf(JSON.serializePretty(resultWithoutAge));
            response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
        } else { 
            try {
                ParamsValidation.validationRequest(touristName, touristAge);
                List<Tourist__c> result = TouristManager.getSameNameAge(touristName, touristAge);
                response.responseBody = Blob.valueOf(JSON.serializePretty(result));
                response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
            } catch (RestRequestValidationException e) {
                response.statusCode = e.getStatusCode();
                response.responseBody = Blob.valueOf(e.getMessage());
            }
        }
    }
    
    @HttpPost
    global static void createTourist(String name, String lastName, String birthdate, String email) {
        RestResponse response = RestContext.response;
        try {
            Tourist__c newTourist = new Tourist__c(
                Name = name,
                LastName__c = lastName,
                Birthdate__c = Date.valueOf(birthdate),
                Email__c = email
            );
            List<Tourist__c> same = TouristManager.getTheSame(new Set<String> {lastName}, new Set<String> {email});
            ParamsValidation.checkDuplicates(same);
            insert newTourist;
        } catch (RestRequestValidationException e) {
            response.statusCode = e.getStatusCode();
            response.responseBody = Blob.valueOf(e.getMessage());
        } catch (TypeException te) {
            response.statusCode = Constants.RESPONSE_STATUS_CODE_409;
            response.responseBody = Blob.valueOf(te.getMessage());
        }
    }
}