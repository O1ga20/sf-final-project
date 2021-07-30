({
    closeModal : function(component, event, helper) {
        let compEvent = component.getEvent("isButtonClose");
        compEvent.fire();
    },
    
    registration : function(component, event, helper) {
        let compEvent = component.getEvent("isButtonYes");
        compEvent.fire();
    }
})