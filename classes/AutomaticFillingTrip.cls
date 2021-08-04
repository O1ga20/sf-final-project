public class AutomaticFillingTrip {
    
    @InvocableMethod(label = 'Automatic Tourist Registration'
                     description = 'Registration of free tourists'
                     category = 'Trip__c')
    public static void fillingTrip(List<Trip__c> trip) {
        
        if (trip == null || trip.isEmpty()) return;
        List<Tourist__c> freeTourists = TouristManager.getNotRegisteredOnTheTrips();
        List<Trip__c> trips = TripManager.getAndTourists(trip);
        List<Tourist__c> filteredTourists = new List<Tourist__c> ();
        List<Flight__c> registerAtourist = new List<Flight__c> ();
        
        for (Tourist__c touristFirst: freeTourists) {
            
            for (Trip__c tripsFirst: trips) {
                Boolean isSuitableForAge = (touristFirst.Age__c >= tripsFirst.Minimum_Age__c);
                if (isSuitableForAge && !filteredTourists.contains(touristFirst)) {
                    filteredTourists.add(touristFirst);
                    Flight__c newRegister = new Flight__c ();
                    newRegister.Tourist__c = touristFirst.Id;
                    newRegister.Trip__c = tripsFirst.Id;
                    newRegister.Status__c = 'Accepted';
                    registerAtourist.add(newRegister);
                }
            }
        }
        insert registerAtourist;
    }
}