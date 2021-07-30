public class WeatherForecastManager {
    
    public static List<Weather_Daily_Forecast__c> getToTheDelete(List<Date> deleteWeatherDates) {
        List<Weather_Daily_Forecast__c> oldWeather = [
            SELECT Date__c
            FROM Weather_Daily_Forecast__c
            WHERE Date__c IN :deleteWeatherDates
        ];
        return oldWeather;
    }
    
    public static List<Date> getDaysWeather() {
        List<Date> days = new List<Date> ();
        List<Weather_Daily_Forecast__c> oldWeather = [
            SELECT Date__c
            FROM Weather_Daily_Forecast__c
        ];
        for (Weather_Daily_Forecast__c weather : oldWeather) {
            days.add(weather.Date__c);
        }
        return days;
    }
    
    public static Weather_Daily_Forecast__c getWeather(Id spacePoint) {
        Weather_Daily_Forecast__c weather = [
            SELECT Id,
            Average_Temperature__c
            FROM Weather_Daily_Forecast__c
            WHERE Date__c = TODAY
            AND Space_Point__c = :spacePoint
        ];
        return weather;
    }
}