@IsTest
public class CustomMetadataTypeManagerTest {
    
    @TestVisible
    private static final String CUSTOM_METADATA_TYPE_NAME = 'Send_Email__mdt';
    
    @IsTest
    private static void getRecords_Test() {
        List<SObject> records = CustomMetadataTypeManager.getRecords(CUSTOM_METADATA_TYPE_NAME);
        
        System.assertNotEquals(null, records);
        System.assertEquals(1, records.size());
    }
}