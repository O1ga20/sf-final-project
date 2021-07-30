public class SpacePointManager {
    
    public static List<Space_Point__c> getPoints() {
        List<Space_Point__c> points = [
            SELECT Latitude__c,
            Longitude__c
            FROM Space_Point__c
        ];
        return points;
    }
    
     public static Space_Point__c getPoint(Id spacePoint) {
     Space_Point__c point = [
            SELECT Id,
            City__c
            FROM Space_Point__c
            WHERE Id = :spacePoint
        ];
        return point;
     }
}