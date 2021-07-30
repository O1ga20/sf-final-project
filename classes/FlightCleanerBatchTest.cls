@IsTest
public class FlightCleanerBatchTest {
    
    @TestVisible
    private static final String JOB_TYPE_BATCH = 'BatchApex';
    
    @IsTest
    private static void cleanerBatch_Test() {
        TestDataFactory.createFlights();
        
        Test.startTest();
        	Database.executeBatch(new FlightCleanerBatch());
        Test.stopTest();
        
        List<AsyncApexJob> jobs = TestDataFactory.getJobs();
        List<Flight__c> flights = TestDataFactory.getFlights();
        
        System.assertEquals(JOB_TYPE_BATCH, jobs[0].JobType);
        System.assertEquals(0, flights.size());
    }
}