@IsTest
public class FlightTriggerTest {
    
    @TestVisible
    private static final String birthdayTorist = '2020-03-03';
    private static final Integer minAgeError = 3;
    private static final Integer minAge = 1;
    private static final String startDate = '2021-08-09';
    private static final String startDateError = '2019-08-09';
    
    @IsTest
    private static void onBeforeInsert_ErrorAge_Test() {
        Flight__c[] flight = TestDataFactory.createFlight(birthdayTorist, minAgeError, startDate, Constants.FLIGHT_STATUS_ACCEPTED);
        
        Test.startTest();
        	Database.SaveResult[] result = Database.insert(flight, false);
        Test.stopTest();
        
        System.assertEquals(false, result[0].isSuccess());
        System.assertEquals(true, result[0].getErrors().size() > 0);
        System.assertEquals(Constants.ERROR_AGE, result[0].getErrors()[0].getMessage());
    }
    
    @IsTest
    private static void onBeforeInsert_ErrorFlewAway_Test() { 
        Flight__c[] flight = TestDataFactory.createFlight(birthdayTorist, minAge, startDateError, Constants.FLIGHT_STATUS_ACCEPTED);
        
        Test.startTest();
        	Database.SaveResult[] result = Database.insert(flight, false);
        Test.stopTest();
        
        System.assert(!result[0].isSuccess());
        System.assert(result[0].getErrors().size() > 0);
        System.assertEquals(Constants.ERROR_DATE, result[0].getErrors()[0].getMessage());
    }
    
    @IsTest
    private static void onBeforeInsert_Success_Test() { 
        Flight__c[] flight = TestDataFactory.createFlight(birthdayTorist, minAge, startDate, Constants.FLIGHT_STATUS_ACCEPTED);
        
        Test.startTest();
        	Database.SaveResult[] result = Database.insert(flight, false);
        Test.stopTest();
        
        System.assert(result[0].isSuccess());
        System.assertEquals(0, result[0].getErrors().size());
    }
}