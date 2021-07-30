@IsTest
public class FlightManagerTest {
    
    @TestVisible
    private static List<Flight__c> flights;
    static {
        TestDataFactory.createFlights();
        flights = TestDataFactory.getFlights();
    } 
    
    @IsTest
    private static void getByActiveTourists_Null_Test() {
        List<Flight__c> notActiveTourists = FlightManager.getByActiveTourists(null);
        
        System.assertEquals(new List<Flight__c> (), notActiveTourists);
    }
    
    @IsTest
    private static void getByActiveTourists_Ssuccess_Test() {
        List<Tourist__c> tourists = TestDataFactory.getTourists();
        List<Flight__c> notActiveTourists = FlightManager.getByActiveTourists(tourists);
        
        System.assertEquals(2, notActiveTourists.size());
    }
    
    @IsTest
    private static void getTripsAndTourists_Null_Test() {
        List<Flight__c> tripsAndTourists = FlightManager.getTripsAndTourists(null);
        
        System.assertEquals(new List<Flight__c> (), tripsAndTourists);
    }
    
    @IsTest
    private static void getTripsAndTourists_Ssuccess_Test() {
        List<Flight__c> flightToSearch = new List<Flight__c> {flights[0]};
        List<Flight__c> tripsAndTourists = FlightManager.getTripsAndTourists(flightToSearch);
        
        System.assertEquals(1, tripsAndTourists.size());
    }
    
    @IsTest
    private static void getName_Null_Test() {
        List<Flight__c> nameFlight = FlightManager.getName(null); 
        
        System.assertEquals(new List<Flight__c> (), nameFlight);
    }
    
    @IsTest
    private static void getName_Ssuccess_Test() {
        List<Flight__c> nameFlightTest = TestDataFactory.getFlightsName(flights);
        List<Tourist__c> tourist = TestDataFactory.getTourists();
        List<Flight__c> nameFlight = FlightManager.getName(tourist);
        
        System.assertEquals(nameFlightTest, nameFlight);
    }
    
    @IsTest
    private static void getFlights_Null_Test() {
        List<Flight__c> foundFlights = FlightManager.getFlights(null);  
        
        System.assertEquals(new List<Flight__c> (), foundFlights);
    }
    
    @IsTest
    private static void getFlights_Ssuccess_Test() {
        List<Flight__c> flights = TestDataFactory.getFlights();
        List<Id> flightsIds = new List<Id> {flights[0].Id};
        List<Flight__c> foundFlights = FlightManager.getFlights(flightsIds);
        
        System.assertEquals(1, foundFlights.size());
    }
}