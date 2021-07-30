@IsTest
public class SpacePointManagerTest {
    
    @TestVisible
    private static final Decimal GRODNO_LATITUDE = 53.68;
    
    @IsTest
    private static void getPoints_Test() {
        TestDataFactory.createSpacePoint();
        List<Space_Point__c> points = SpacePointManager.getPoints();
        
        System.assertEquals(1, points.size());
        System.assertEquals(GRODNO_LATITUDE, points[0].Latitude__c);
    }
}