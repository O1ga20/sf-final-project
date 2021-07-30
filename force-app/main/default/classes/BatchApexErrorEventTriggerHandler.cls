public class BatchApexErrorEventTriggerHandler {
    public static Boolean isFirstTime = true;
    
    public static void onAfterInsert(List<BatchApexErrorEvent> errors) {
        Set<Id> asyncApexJobIds = new Set<Id> ();
        
        for(BatchApexErrorEvent evt : errors) {
            asyncApexJobIds.add(evt.AsyncApexJobId);
        }
        Map<Id, AsyncApexJob> jobs = new Map<Id, AsyncApexJob> (AsyncJobManager.getJobs(asyncApexJobIds));
        List<Error_Log__c> records = new List<Error_Log__c> ();
        
        for(BatchApexErrorEvent evt : errors) {
            if(jobs.get(evt.AsyncApexJobId).ApexClass.Name == FlightCleanerBatch.class.getName()) {
                
                for (String item : evt.JobScope.split(',')) {
                    Error_Log__c record = new Error_Log__c(
                        Records__c = (Id)item,
                        JobId__c = evt.AsyncApexJobId,
                        Error__c = evt.ExceptionType
                    );
                    records.add(record);
                }
            }
        }
        insert records;
    }
}