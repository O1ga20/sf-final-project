global class WeatherForecastUpdaterSchedulable implements Schedulable {
    global void execute(SchedulableContext ctx) {
        WeatherForecastUpdater.updateForecasts();
    }
}

/*Apex-script 
WeatherForecastUpdaterSchedulable updateForecasts = new WeatherForecastUpdaterSchedulable();
String sch = '0 0 0 * * ?';
String jobID = System.schedule('Update forecasts', sch, updateForecasts);*/