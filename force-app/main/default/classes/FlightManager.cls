public class FlightManager {
    
    public static List<Flight__c> getByActiveTourists(List<Tourist__c> newTourists) {
        if (newTourists == null || newTourists.isEmpty()) {
            return new List<Flight__c> ();
        }
        List<Flight__c> notActiveTourists = [
            SELECT Status__c,
            Tourist__c,
            Tourist__r.Active__c
            FROM Flight__c
            WHERE Tourist__r.Active__c = false AND Tourist__c = :newTourists
        ];
        return notActiveTourists;
    }
    
    public static List<Flight__c> getTripsAndTourists(List<Flight__c> newFlights) {
        if (newFlights == null || newFlights.isEmpty()) {
            return new List<Flight__c> ();
        }
        List<Flight__c> tripsAndTourists = [
            SELECT Tourist__c,
            Trip__c,
            Tourist__r.Age__c, 
            Trip__r.Start_Date__c, 
            Trip__r.Minimum_Age__c
            FROM Flight__c
            WHERE Id IN: newFlights
        ];
        return tripsAndTourists;
    }
    
    public static List<Flight__c> getName(List<Tourist__c> tourist) {
        if (tourist == null) {
            return new List<Flight__c> ();
        }
        List<Flight__c> nameFlight = [
            SELECT Name 
            FROM Flight__c 
            WHERE Tourist__c =: tourist[0].Id LIMIT 1
        ];
        return nameFlight;
    }
    
    public static List<Flight__c> getFlights(List<Id> flightsIds) {
        if (flightsIds == null || flightsIds.isEmpty()) {
            return new List<Flight__c> ();
        }
        List<Flight__c> flights = [
            SELECT Id,
            Name,
            Tourist__c,
            Tourist__r.Name,
            Tourist__r.LastName__c
            FROM Flight__c 
            WHERE Id IN :flightsIds
        ];
        return flights;
    }
}