public class TripService {
    
    public static void createFlights(Id tripId, List<Id> touristIds) {
        List<Flight__c> newFlights = new List<Flight__c> ();
        for (Id touristId : touristIds) {
            Flight__c newFlight = new Flight__c ();
            newFlight.Tourist__c = touristId;
            newFlight.Trip__c = tripId;
            newFlight.Status__c = Constants.FLIGHT_STATUS_OFFER_PENDING;
            newFlights.add(newFlight);
        }     
        insert newFlights;
    }
    
    public static void createFlight(Id tripId, Id touristId) {
        Flight__c newFlight = new Flight__c ();
        newFlight.Tourist__c = touristId;
        newFlight.Trip__c = tripId;
        newFlight.Status__c = Constants.FLIGHT_STATUS_OFFER_REQUESTED;
        insert newFlight;
    }
}