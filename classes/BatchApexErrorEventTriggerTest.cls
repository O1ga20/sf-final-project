@IsTest
public class BatchApexErrorEventTriggerTest {
    
    @TestVisible
    private static final String EXCEPTION_TYPE = 'System.DmlException';
    private static final String JOB_SCOPE = '001B000001LVF4fIAH';
    
    @IsTest
    private static void onAfterInsert_Test() {
        TestDataFactory.createFlights();
        String jobId = Database.executeBatch(new FlightCleanerBatch());
        
        List<BatchApexErrorEvent> errEvt = new List<BatchApexErrorEvent> {
            new BatchApexErrorEvent(
                AsyncApexJobId = jobId,
                ExceptionType = EXCEPTION_TYPE,
                JobScope = JOB_SCOPE,
                DoesExceedJobScopeMaxLength = false)
            };
                    
        Test.startTest();
        	List<Database.SaveResult> results = EventBus.publish(errEvt);
        Test.stopTest();
        
        List<Error_Log__c> errs = TestDataFactory.getErrorLog();
        
        System.assertEquals(true, results.get(0).isSuccess());
        System.assertEquals(1, errs.size());
        System.assertEquals(jobId, errs.get(0).JobId__c);
    }
}