@IsTest
public class AsyncJobManagerTest {
    
    @IsTest
    private static void getJobs_Test() {
        List<AsyncApexJob> jobs = AsyncJobManager.getJobs(null);

        System.assertEquals(0, jobs.size());
    }
}