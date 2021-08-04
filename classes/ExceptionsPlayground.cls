public class ExceptionsPlayground {
    public class CustomException extends Exception {}
    
    public static void generateCustomException() {
        try {
            Tourist__c touristFirst = new Tourist__c ();
            Flight__c flighttouristFirst = new Flight__c(
                Status__c = Constants.FLIGHT_STATUS_ACCEPTED,
                Tourist__c = touristFirst.Id,
                Trip__c = 'a085g0000011IV3AAM'
            );
            insert flighttouristFirst;
        } catch (DmlException e) {
            throw new CustomException(Constants.EXECEPTION_TEXT + e.getCause());
        }
    }
    
    public static void generateRegularException() {
        Tourist__c touristFirst = new Tourist__c ();
        insert touristFirst;
    }
    
    public static void handleExceptions() {
        try {
            generateCustomException();
            generateRegularException();
        } catch (DmlException e) {
            System.debug(Constants.EXECEPTION_DML);    
        } catch (QueryException qe) {
            System.debug(Constants.EXECEPTION_QUERY);    
        } catch (Exception ex) {
            System.debug(Constants.EXECEPTION_GENERAL);    
        }
    }
}