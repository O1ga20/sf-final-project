@IsTest
public class TripManagerTest {
    
    static {
        TestDataFactory.createFlights();
    }
    
    @IsTest
    private static void getAndTourists_Null_Test(){
        List<Trip__c> foundtrips = TripManager.getAndTourists(null);
            
        System.assertEquals(true, foundtrips.isEmpty());
        System.assertEquals(0, foundtrips.size());
    }
    
    @IsTest
    private static void getAndTourists_Ssuccess_Test(){
        List<Trip__c> trips = new List<Trip__c> {TestDataFactory.getTrips()[0]};
        List<Trip__c> foundtrips = TripManager.getAndTourists(trips);
        
        System.assertNotEquals(true, foundtrips.isEmpty());
        System.assertEquals(1, foundtrips.size());
    }
    
    @IsTest
    private static void getIdMinAgeDate_Null_Test() {
        List<Trip__c> trips = TripManager.getIdMinAgeDate(null);
        
        System.assertEquals(true, trips.isEmpty());
        System.assertEquals(0, trips.size());
    }
    
    @IsTest
    private static void getIdMinAgeDate_Ssuccess_Test() {
        List<Flight__c> flights = TestDataFactory.getFlights();
        List<Trip__c> trips = TripManager.getIdMinAgeDate(flights); 
        
        System.assertNotEquals(true, trips.isEmpty());
        System.assertEquals(2, trips.size());
    }
}