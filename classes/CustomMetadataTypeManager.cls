public class CustomMetadataTypeManager {
    
    public static List<SObject> getRecords(String customMetadataTypeName) {
        Map<String,Schema.SObjectField> fields = Schema.getGlobalDescribe().get(customMetadataTypeName).getDescribe().fields.getMap();
        List<String> fieldsForQuery = new List<String>();
        
        for (String field : fields.keySet()) {
            fieldsForQuery.add(String.valueOf(fields.get(field)));
        }
        String query = 
            'SELECT ' + String.join(fieldsForQuery, ', ') + 
            ' FROM ' + customMetadataTypeName;
        List<SObject> records = Database.query(query);
        return records;
    }
}