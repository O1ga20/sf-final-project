@IsTest
public class FlightCleanerScheduleTest {
    
    @TestVisible
    private static final String sch = '0 0 0 * * ?';
    private static final String SCHEDULE_JOB_NAME = 'Cleaning flights';
    private static final String JOB_TYPE_SCHEDULE = 'ScheduledApex';
    
    @IsTest
    private static void cleanerSchedule_Test() {
        TestDataFactory.createFlights();
        
        Test.startTest();
        	FlightCleanerSchedule cleaner = new FlightCleanerSchedule();
        	System.schedule(SCHEDULE_JOB_NAME, sch, cleaner);
        Test.stopTest();
        
        List<AsyncApexJob> jobs = TestDataFactory.getJobs();
        
        System.assertEquals(1, [SELECT count() FROM CronTrigger], 'A job should be scheduled');
        System.assertEquals(JOB_TYPE_SCHEDULE, jobs[0].JobType);
    }
}