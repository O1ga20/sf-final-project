public without sharing class PricePDFTripsExtensions {
    public static final String touristId = 'Id';
    public Tourist__c tourist {get; set;}
    public List<String> tripNames {get; set;}
    public List<Trip__c> trips {get; set;}
    public List<PriceBookEntry> price {get; set;}
    
    public PricePDFTripsExtensions(ApexPages.StandardController controller) {
        tourist = TouristManager.getTourist(ApexPages.CurrentPage().getParameters().get(touristId));
        trips = TripManager.getTripValid(tourist);
        tripNames = new List<String>();
        
        for (Trip__c trip : trips) {
            tripNames.add(trip.Name);
        }
        price = PriceBookEntryManager.getPriseTripsSpaceTourism(tripNames);
    }
}