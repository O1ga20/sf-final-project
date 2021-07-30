({
    getTripDetail : function(component, event, helper) {
        let selectedItem = event.currentTarget; 
        let index = selectedItem.dataset.record; 
        let selectTrip = component.get("v.trips")[index];
        component.set("v.selectTripId", selectTrip.Id);
        let compEvent = component.getEvent("selectedTripId");
        compEvent.setParams({
            "selectedTripId" : component.get("v.selectTripId")
        });
        compEvent.fire();
    }
})