({
    hangeIt : function(cmp, event, helper) {
        let newVal = cmp.get("v.changeTo");
        cmp.set("v.changeTo", newVal);
        cmp.find("lookupId").fireChanging();
    },
    
    openModal : function(component) {
        component.set("v.isModalOpen", true);
    },
    
    submit : function(component, event, helper) {
        component.set("v.isModalOpen", false);
        helper.showSpinner(component);
        helper.createFlight(component, event);
    },
    
    selectedTourist : function(component, event, helper) {
        helper.showSpinner(component);
        helper.getDataForMap(component, event);
        helper.сearchTrip(component, event);
        component.set("v.activeCardTrips", true);
        helper.hideSpinner(component);
    },
    
    getTripDetail : function(component, event, helper) {
        let selectedTripId = event.getParam("selectedTripId");
        component.set("v.selectedTripId", selectedTripId);
        helper.getTrip(component, event);
        helper.getCity(component, event);
        helper.getWeather(component, event);
        helper.zoomMap(component, event);
        component.set("v.activeInformationTrip", true);
        helper.hideSpinner(component);
    },
    
    handleMarkerSelect: function (event) {
        let marker = event.getParam("selectedMarkerValue");
    },
    
    closeModal : function(component, event) {
        let isModalOpen = event.getSource();
        component.set("v.isModalOpen", false);
    }    
})