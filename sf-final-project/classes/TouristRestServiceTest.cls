@IsTest
public class TouristRestServiceTest {
    
    @TestVisible
    private static final String REQUEST_URL = URL.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/Tourist';
    private static final String REQUEST_PARAMS_FUZZYNAME = 'fuzzyname';
    private static final String REQUEST_PARAMS_AGE = 'age';
    private static final String AGE = '5';
    private static final String TOURIST_NAME = 'Olga';
    private static final String TOURIST_LAST_NAME = 'Taras';
    private static final String TOURIST_BIRTHDAY = '2020-03-03';
    private static final String TOURIST_EMAIL = 'romandlickaya@gmail.com';
    private static final String TOURIST_EMAIL_NOT_DUPLICATE = 'roman@gmail.com';
    private static final String ASSERT_COMMENT = 'Insert failed.';
    private static List<Tourist__c> tourist;
    static {
        tourist = TestDataFactory.createTourist();
    }
    
    @IsTest
    private static void getTourists_Ssuccess_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = REQUEST_URL;
        req.params.put(REQUEST_PARAMS_FUZZYNAME, tourist.get(0).Name);
        req.params.put(REQUEST_PARAMS_AGE, AGE);
        req.httpMethod = Constants.METHOD_HTTP_GET; 
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();      
        
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals(3, RestContext.response.responseBody.size());
    }
    
    @IsTest
    private static void getTourist_SsuccessfulWithoutAge_Test() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = REQUEST_URL;
        req.params.put(REQUEST_PARAMS_FUZZYNAME, tourist.get(0).Name); 
        req.httpMethod = Constants.METHOD_HTTP_GET;  
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();      
        
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals(3, RestContext.response.responseBody.size());
    }
    
    @IsTest
    private static void getTourists_ErrorNotNameTourist_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = REQUEST_URL;
        req.params.put(REQUEST_PARAMS_AGE, AGE);
        req.httpMethod = Constants.METHOD_HTTP_GET; 
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();      
        
        System.assertEquals(404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_TOURIST_NAME_EMPTY, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void getTourists_ErrorAgeNotNumbers_Test() {
        String ageNotNumber = 'ghjliu';
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = REQUEST_URL;
        req.params.put(REQUEST_PARAMS_FUZZYNAME, tourist.get(0).Name);
        req.params.put(REQUEST_PARAMS_AGE, ageNotNumber);
        req.httpMethod = Constants.METHOD_HTTP_GET; 
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();  
        
        System.assertEquals(404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_TOURIST_AGE_NOT_NUMBER, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void createTourist_Duplicate_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = REQUEST_URL;
        req.httpMethod = Constants.METHOD_HTTP_POST;  
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.createTourist(TOURIST_NAME, TOURIST_LAST_NAME, TOURIST_BIRTHDAY, TOURIST_EMAIL);
        Test.stopTest(); 
        
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        
        System.assertEquals(1, tourists.size(), ASSERT_COMMENT);
        System.assertEquals(409, RestContext.response.statusCode);
        System.assertEquals(Constants.DUPLICATE, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void createTourist_TypeException_Test() {
        String birthdayError = '2020/03/03';
        String textError = 'Invalid date: 2020/03/03';
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = REQUEST_URL;
        req.httpMethod = Constants.METHOD_HTTP_POST;  
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.createTourist(TOURIST_NAME, TOURIST_LAST_NAME, birthdayError, TOURIST_EMAIL);
        Test.stopTest(); 
        
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        
        System.assertEquals(1, tourists.size(), ASSERT_COMMENT);
        System.assertEquals(409, RestContext.response.statusCode);
        System.assertEquals(textError, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void createTourist_Ssuccess_Test() {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = REQUEST_URL;
        req.httpMethod = Constants.METHOD_HTTP_POST;  
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        	TouristRestService.createTourist(TOURIST_NAME, TOURIST_LAST_NAME, TOURIST_BIRTHDAY, TOURIST_EMAIL_NOT_DUPLICATE);
        Test.stopTest(); 
        
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        
        System.assertEquals(2, tourists.size());
        System.assertEquals(TOURIST_EMAIL_NOT_DUPLICATE, tourists[1].Email__c);
    }
}