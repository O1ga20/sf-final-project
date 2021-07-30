@IsTest
global class WeatherForecastServiceMockError implements HttpCalloutMock {
    
    public static Boolean returnValue = false;
    
    global HTTPResponse respond(HTTPRequest request) {
        returnValue = true;
        throw new WeatherForecastService.WeatherForecastException(Constants.ERROR); 
    }
}