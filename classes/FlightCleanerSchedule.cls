global class FlightCleanerSchedule implements Schedulable {
    global void execute(SchedulableContext ctx) {
        FlightCleanerBatch flightCleanerBatch = new FlightCleanerBatch();
        Database.executeBatch(flightCleanerBatch);
    }
}
/*Apex-script 2.5.4
FlightCleanerSchedule cleaner = new FlightCleanerSchedule();
String sch = '0 0 0 * * ?';
String jobID = System.schedule('Cleaning flights', sch, cleaner);

Apex-script 2.5.4.1
FlightCleanerSchedule cleaner = new FlightCleanerSchedule();
String sch = '0 30 * * * ?';
String jobID = System.schedule('Cleaning flights second', sch, cleaner);*/