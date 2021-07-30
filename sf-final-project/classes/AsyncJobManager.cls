@IsTest
public class AsyncJobManagerTest {
    
    @TestVisible
    private static final String APEX_CLASS_NAME = 'FlightCleanerBatch';
    
    @IsTest
    private static void getJobs_Null_Test() {
        List<AsyncApexJob> jobs = AsyncJobManager.getJobs(null);
        
        System.assertEquals(true, jobs.isEmpty());
        System.assertEquals(0, jobs.size());
    }
    
    @IsTest
    private static void getJobs_Test() {
        Test.startTest();
        	String jobId = Database.executeBatch(new FlightCleanerBatch());
        Test.stopTest();
        
        Set<Id> jobsIds = TestDataFactory.getJobsId(jobId);
        List<AsyncApexJob> jobs = AsyncJobManager.getJobs(jobsIds);
        
        System.assertEquals(false, jobs.isEmpty());
        System.assertEquals(1, jobs.size());
        System.assertEquals(APEX_CLASS_NAME, jobs[0].ApexClass.Name);
    }
}