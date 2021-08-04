public class EmailService {
    
    public static void sendEmailFromFlightCleanerBatch(Map<Id, Integer> touristOnFlight) {
        String recordLink = '';
        List<Tourist__c> tourists = TouristManager.getTourists(touristOnFlight.keySet());
        String customMetadataTypeName = Constants.CUSTOM_METADATA_TYPE_NAME;
        List<SObject> records = CustomMetadataTypeManager.getRecords(customMetadataTypeName);
        List<String> emails = new List<String> ();
        
        for (SObject record : records) {
            emails.add(String.valueOf(record.get('Email__c')));
        }
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(emails);
        message.setSubject(Constants.EMAIL_SUBJECT_FLIGHT_CLEANER);
        
        for (Tourist__c tourist : tourists) {
            recordLink += (
                '<a href=' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + tourist.Id + '>' 
                + tourist.Name + ' ' + tourist.LastName__c + '</a>' + 
                ' : ' + touristOnFlight.get(tourist.Id) + '<br>'
            );
        }
        message.setHtmlBody(
            'Batch completed. Flights removed. ' +
            'Tourists and the number of remote flights for each tourist: <br>' + 
            recordlink
        );
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message});
    }
}