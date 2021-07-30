public inherited sharing class TouristRegistrationController {
    
    @AuraEnabled(cacheable=true)
    public static List<Tourist__c> getTourists(Id tripId, Integer recordLimit, Integer recordOffset) {
        Integer intLimit = Integer.valueof(recordLimit);
        Integer intOffset = Integer.valueof(recordOffset);
        Trip__c trip = TripManager.getTrip(tripId);
        List<Tourist__c> tourists = TouristManager.getSuitableForATrip(tripId, trip, intLimit, intOffset);
        return tourists;
    }
    
    @AuraEnabled(cacheable=true)
    public static Integer getTotalNumTourists(Id tripId) {
        Trip__c trip = TripManager.getTrip(tripId);
        Integer numTourists = TouristManager.getTotalNumTourists(tripId, trip); 
        return numTourists;
    } 
    
    @AuraEnabled
    public static void createFlights(Id tripId, List<Id> touristIds) {
        TripService.createFlights(tripId, touristIds);
    }
}