@IsTest
public class WeatherForecastManagerTest {
    
    @TestVisible
    private static final String WEATHER_DATE = '2021-06-01';
    private static List<Space_Point__c> points;
    static {
        TestDataFactory.createSpacePoint();
        points = TestDataFactory.getSpacePoint();
        TestDataFactory.createWeatherDailyForecast(points);
    }

    @IsTest
    private static void getToTheDelete_Test() {
       List<Weather_Daily_Forecast__c> weather = WeatherForecastManager.getToTheDelete(new List<Date> {Date.valueOf(WEATHER_DATE)});
       
       System.assertEquals(false, weather.isEmpty());
       System.assertEquals(1, weather.size());
    }
    
    @IsTest
    private static void getDaysWeather_Test() {
       List<Date> dateWeather = WeatherForecastManager.getDaysWeather();
       
       System.assertEquals(false, dateWeather.isEmpty()); 
       System.assertEquals(new List<Date> {Date.valueOf(WEATHER_DATE)}, dateWeather);
    }
}