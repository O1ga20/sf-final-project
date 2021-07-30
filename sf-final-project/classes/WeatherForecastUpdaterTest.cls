@IsTest
public class WeatherForecastUpdaterTest {
    
    @TestVisible
    private static List<Space_Point__c> points;
    static {
        TestDataFactory.createSpacePoint();
        points = TestDataFactory.getSpacePoint();
    }
    
    @IsTest
    private static void updateForecasts_Ssuccess_Test() {
        Test.setMock(HttpCalloutMock.class, new WeatherForecastServiceMock());
        
        Test.startTest();
        	WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> weathers = TestDataFactory.getWeatherForecast();
        
        System.assertEquals(false, weathers.isEmpty());
        System.assertEquals(1, weathers.size());
    }
    
    @IsTest
    private static void updateForecasts_DeleteWeatherDate_Test() {
        TestDataFactory.createWeatherDailyForecast(points);
        Test.setMock(HttpCalloutMock.class, new WeatherForecastServiceMock());
        
        Test.startTest();
        	WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> weathersAfterUpdate = TestDataFactory.getWeatherForecast();
        
        System.assertEquals(false, weathersAfterUpdate.isEmpty());
        System.assertEquals(1, weathersAfterUpdate.size());
    }
    
    @IsTest
    private static void updateForecasts_Error_Test() {
        Test.setMock(HttpCalloutMock.class, new WeatherForecastServiceMockError());
        
        Test.startTest();
            try{
                WeatherForecastUpdater.updateForecasts();
            } catch (WeatherForecastService.WeatherForecastException e) {
                System.assertEquals(Constants.ERROR, e.getMessage()); 
            }
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> weathersAfterUpdate = TestDataFactory.getWeatherForecast();
        
        System.assertEquals(true, WeatherForecastServiceMockError.returnValue);
        System.assertEquals(0, weathersAfterUpdate.size());

    }
}