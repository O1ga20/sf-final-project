({
    doInit : function(component, event, helper) {
        var touristId = decodeURIComponent(location.search.split("Id=")[1]);
        component.set("v.touristId", touristId);
        helper.getDataForMap(component, event);
        helper.сearchTrips(component, event);
    },
    
    openModal : function(component) {
        component.set("v.isModalOpen", true);
    },
    
    submit : function(component, event, helper) {
        component.set("v.isModalOpen", false);
        helper.showSpinner(component);
        helper.createFlight(component, event);
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