public with sharing class WeatherForecastService {
    public class WeatherForecastException extends Exception {}
    private static final String RESPONSE_BODY_DATA = 'data';
    private static final String RESPONSE_BODY_DATA_VALID_DATE = 'valid_date';
    private static final String RESPONSE_BODY_DATA_TEMP = 'temp';
    
    public static Map<Date, Double> getForecasts(Double latitude, Double longitude) {
        HttpRequest req = new HttpRequest();
        req.setMethod(Constants.METHOD_HTTP_GET);
        req.setEndpoint(
            'callout:Rapidapi_Weatherbit' + '?lat=' + latitude +
            '&lon=' + longitude
        );
        req.setHeader(Constants.REQUEST_HEADER_RAPIDAPI_KEY_TEXT, Constants.REQUEST_HEADER_RAPIDAPI_KEY);
        req.setHeader(Constants.REQUEST_HEADER_RAPIDAPI_HOST_TEXT, Constants.REQUEST_HEADER_RAPIDAPI_HOST);
        Map<Date, Double> temperatureByDate = new Map<Date, Double> ();
        
        try {
            Http http = new Http();
            HTTPResponse res = http.send(req);
            if(res.getStatusCode() == Constants.RESPONSE_STATUS_CODE_200) {
                Map<String, Object> results =(Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                List<Object> data = (List<Object>)results.get(RESPONSE_BODY_DATA);
                
                for (Integer i = 0; i < data.size(); i++){
                    Map<String, Object> weatherByDay = (Map<String, Object>)data[i];
                    Date validDate = Date.valueOf(String.valueOf(weatherByDay.get(RESPONSE_BODY_DATA_VALID_DATE)));
                    Double temp = Double.valueOf(String.valueOf(weatherByDay.get(RESPONSE_BODY_DATA_TEMP)));
                    temperatureByDate.put(validDate, temp);
                }
            }
        } catch (WeatherForecastException e) {
            System.debug(LoggingLevel.ERROR, e.getMessage());
        } 
        return temperatureByDate;
    }
}