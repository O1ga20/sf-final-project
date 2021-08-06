public class TripManager {
    
    public static List<Trip__c> getAndTourists(List<Trip__c> trips) {
        if (trips == null || trips.isEmpty()) {
            return new List<Trip__c> ();
        }
        List<Trip__c> andTourists = [
            SELECT Id,
            Name,
            Minimum_Age__c,
            (SELECT Id, Tourist__r.Name, Tourist__r.Age__c FROM Flights__r)
            FROM Trip__c 
            WHERE Id IN :trips
        ];
        return andTourists;
    }
    
    public static List<Trip__c> getIdMinAgeDate(List<Flight__c> newFlights) {
        if (newFlights == null || newFlights.isEmpty()) {
            return new List<Trip__c> ();
        }
        Set<Id> tripFlights = new Set<Id> ();
        for (Flight__c flight : newFlights) {
            tripFlights.add(flight.Trip__c);
        }
        List<Trip__c> trips = [
            SELECT Minimum_Age__c,
            Start_Date__c
            FROM Trip__c
            WHERE Id IN: tripFlights
        ];
        return trips;
    }
    
    public static Trip__c getTrip(Id tripId) {
        if (tripId == null) {
            return new Trip__c ();
        }
         Trip__c trip = [
            SELECT Name,
            Free_Seats__c,
            Minimum_Age__c,
            Start_Date__c,
            End_Date__c,
            Seats__c,
            Departure_Space_Point__c,
            Departure_Space_Point__r.City__c
            FROM Trip__c
            WHERE Id =: tripId
        ];
        return trip;
    }
    
    public static List<Trip__c> getTripValid(Tourist__c tourist) {
        if (tourist == null) {
            return new List<Trip__c> ();
        }
        List<Trip__c> trips = [
            SELECT Name,
            Minimum_Age__c,
            Start_Date__c,
            End_Date__c,
            Free_Seats__c,
            Departure_Space_Point__r.Name,
            Departure_Space_Point__r.City__c
            FROM Trip__c
            WHERE Minimum_Age__c <: tourist.Age__c
            AND Start_Date__c > TODAY
            AND Id NOT IN (SELECT Trip__c 
                FROM Flight__c 
                WHERE Tourist__c = :tourist.Id)
            AND Free_Seats__c > 0
            ORDER BY Name
        ];
        return trips;
    }
}