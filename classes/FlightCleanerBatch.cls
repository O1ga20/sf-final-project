public with sharing class FlightCleanerBatch implements Database.BatchablesObject, Database.Stateful, Database.RaisesPlatformEvents {
    private final String query = 
        'SELECT Id, Status__c, CreatedDate, Tourist__c ' +
        'FROM Flight__c ' +
        'WHERE Status__c =  '' + Constants.FLIGHT_STATUS_DECLINED + ''' +
        'OR CreatedDate  NEXT_N_DAYS ' + Constants.FLIGHT_CLEANER_DAYS + '';
    private Integer counter;
    private MapId, Integer touristOnFlight = new MapId, Integer ();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, ListFlight__c flights) {
        Database.DeleteResult[] deleteResults = Database.delete(flights, false);
        MapId, Flight__c flightById = new MapId, Flight__c (flights);
        
        for(Database.DeleteResult deleteResult  deleteResults) {
            if (deleteResult.isSuccess()) {
                if(touristOnFlight.containsKey(flightById.get(deleteResult.getId()).Tourist__c)) {
                    counter = touristOnFlight.get(flightById.get(deleteResult.getId()).Tourist__c) + 1;
                    touristOnFlight.put(flightById.get(deleteResult.getId()).Tourist__c, counter);
                } else {
                    touristOnFlight.put(flightById.get(deleteResult.getId()).Tourist__c, 1);
                }
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        EmailService.sendEmailFromFlightCleanerBatch(touristOnFlight);
    }
}