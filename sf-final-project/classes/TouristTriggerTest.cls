@IsTest
public class TouristTriggerTest {
    
    @TestSetup
    static void setup() {
        TestDataFactory.createFlights();
    }
    
    @IsTest
    private static void onAfterInsert_Test() {
        List<Tourist__c> tourist = TestDataFactory.createTourist();
        
        Test.startTest(); 
        	Database.SaveResult[] result = Database.insert(tourist, false);
        Test.stopTest();
        
        List<Tourist__c> tourisDuplicates = TestDataFactory.getTouristsIsDuplicate();
        
        System.assertNotEquals(true, tourisDuplicates.isEmpty());
        System.assertEquals(1, tourisDuplicates.size());
    }
    
    @IsTest
    private static void onAfterUpdate_Test() {
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        tourists[0].Active__c = false;
        
        Test.startTest();
        	Database.SaveResult[] result = Database.update(tourists, false);
        Test.stopTest();
        
        List<Flight__c> flights = TestDataFactory.getFlights();
        
        System.assertEquals(Constants.FLIGHT_STATUS_DECLINED, flights[0].Status__c);
    }
}