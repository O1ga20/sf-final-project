public class TripInfoExtensions {
    public List<Tourist__c> notRegistered {get; set;}
    
    public TripInfoExtensions(ApexPages.StandardController controller) {
        notRegistered = TouristManager.getNotRegisteredOnTheTrip(System.currentPageReference().getParameters().get('id'));
    }
}