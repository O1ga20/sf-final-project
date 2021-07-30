public class ParamsValidation {
    
    public static void validationRequest(String touristName, String touristAge) {
        if(String.isEmpty(touristName)) {
            String resBody = Constants.RESPONSE_BODY_TOURIST_NAME_EMPTY;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_404;
            throw new RestRequestValidationException(resBody, statusCode);
        } else if(!touristAge.isNumeric()) {
            String resBody = Constants.RESPONSE_BODY_TOURIST_AGE_NOT_NUMBER;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_404;
            throw new RestRequestValidationException(resBody, statusCode);
        }
    }
    
    public static void checkDuplicates(List<Tourist__c> same) {
        if (!same.isEmpty()) {
            String resBody = Constants.DUPLICATE;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_409;
            throw new RestRequestValidationException(resBody, statusCode);
        } 
    }
}