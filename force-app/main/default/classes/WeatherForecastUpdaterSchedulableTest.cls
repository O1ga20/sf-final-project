@IsTest
public class WeatherForecastUpdaterSchedulableTest {
    
    @TestVisible
    private static final String sch = '0 0 0 * * ?';
    private static final String SCHEDULE_JOB_NAME = 'Updating Weather Forecas';
    private static final String JOB_TYPE_SCHEDULE = 'ScheduledApex';
    
    @IsTest
    private static void updaterWeather_Test() {
        TestDataFactory.createSpacePoint();
        List<Space_Point__c> points = TestDataFactory.getSpacePoint();
        TestDataFactory.createWeatherDailyForecast(points);
        Test.setMock(HttpCalloutMock.class, new WeatherForecastServiceMock());
        
        Test.startTest();
        	WeatherForecastUpdaterSchedulable updater = new WeatherForecastUpdaterSchedulable();
        	System.schedule(SCHEDULE_JOB_NAME, sch, updater);
        Test.stopTest();
        
        List<AsyncApexJob> jobs = TestDataFactory.getJobs();
        
        System.assertEquals(1, [SELECT count() FROM CronTrigger], 'A job should be scheduled');
        System.assertEquals(JOB_TYPE_SCHEDULE, jobs[0].JobType);
    }
}