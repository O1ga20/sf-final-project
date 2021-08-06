public class PriceBookEntryManager {
    
    public static List<PriceBookEntry> getPriseTripsSpaceTourism(List<String> tripNames) {
        if (tripNames == null || tripNames.isEmpty()) {
            return new List<PriceBookEntry> ();
        }
        List<PriceBookEntry> price = [
            SELECT Name, 
            PriceBook2.Name, 
            UnitPrice 
            FROM PriceBookEntry  
            WHERE Name IN :tripNames 
            AND PriceBook2.Name='Space tourism'
        ];
        return price;
    }
}