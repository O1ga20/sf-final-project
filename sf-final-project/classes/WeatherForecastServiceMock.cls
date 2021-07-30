@IsTest
global class WeatherForecastServiceMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"data":[{"valid_date":"2021-06-01", "temp":11.2}] }');
        response.setStatusCode(Constants.RESPONSE_STATUS_CODE_200);
        return response; 
    }
}