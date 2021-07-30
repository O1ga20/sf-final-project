public class TouristService {
    
    @future
    public static void markDuplicates(Set<Id> touristIds) {
        if (touristIds == null || touristIds.isEmpty()) return;
        List<Tourist__c> newTourists = TouristManager.getTourists(touristIds);
        Set<String> lastnames =  new Set<String> ();
        Set<String> emails = new Set<String> ();
        
        for (Tourist__c t : newTourists) {
            lastnames.add(t.LastName__c);
            emails.add(t.Email__c);
        }
        List<Tourist__c> existingTourists  = TouristManager.getTheSame(lastnames, emails);
        
        for (Tourist__c newTourist : newTourists) {
            
            for (Tourist__c existingTourist : existingTourists ) {
                Boolean isSameEmail = (newTourist.Email__c == existingTourist.Email__c);
                Boolean isSameLastName = (newTourist.LastName__c == existingTourist.LastName__c);
                Boolean isSameId = (newTourist.Id == existingTourist.Id);
                if (isSameEmail && isSameLastName && !isSameId) {
                    newTourist.IsDuplicate__c = true;
                }
            }
        }
        update newTourists;
    }
}