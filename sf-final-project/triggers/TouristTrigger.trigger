trigger TouristTrigger on Tourist__c(after insert, after update) {
    
    if(TouristTriggerHandler.isFirstTime){
        TouristTriggerHandler.isFirstTime = false;
        
        switch on Trigger.operationType {
            when AFTER_INSERT {
                TouristTriggerHandler.onAfterInsert(Trigger.newMap);
            }
            when AFTER_UPDATE {
                TouristTriggerHandler.onAfterUpdate(Trigger.new);
            }
        }
    }
}