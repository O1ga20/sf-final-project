@IsTest
public class TouristServiceTest {
    
    @TestSetup
    static void setup() {
        TestDataFactory.createFlights();
    }
        
    @IsTest
    private static void markDuplicates_Null_Test() {
        Test.startTest();
        	TouristService.markDuplicates(null);
        Test.stopTest();
        
        List<Tourist__c> tourisDuplicates = TestDataFactory.getTouristsIsDuplicate();
        
        System.assertEquals(true, tourisDuplicates.isEmpty());
        System.assertEquals(0, tourisDuplicates.size());
    }
    
    @IsTest
    private static void markDuplicates_Ssuccess_Test() {
        List<Tourist__c> tourists = TestDataFactory.createTourist();
        Set<Id> touristsIds = new Set<Id> {tourists[0].Id};
            
        Test.startTest(); 
        	TouristService.markDuplicates(touristsIds);
        Test.stopTest();
        
        List<Tourist__c> tourisDuplicates = TestDataFactory.getTouristsIsDuplicate();
        
        System.assertEquals(false, tourisDuplicates.isEmpty());
        System.assertEquals(1, tourisDuplicates.size());
        System.assertEquals(tourists[0].Id, tourisDuplicates[0].Id);
    }
}