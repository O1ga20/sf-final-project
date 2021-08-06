({
    getDataForMap : function(component, event){
        component.set('v.mapMarkers', [
            {
                location: {
                    City: 'Grodno',
                    Country: 'Belarus'
                },
                title: 'SP-0001',
                value: 'Belarus',
                icon: 'custom:custom26'
            },
            {
                location: {
                    City: 'Dubai',
                    Country: 'United-Arab-Emirates'
                },
                value: 'United-Arab-Emirates',
                icon: 'custom:custom96',
                title: 'SP-0003'
            },
            {
                location: {
                    City: 'Sydney',
                    Country: 'Australia'
                },
                value: 'Australia',
                icon: 'custom:custom92',
                title: 'SP-0004'
            },
            {
                location: {
                    City: 'Moscow',
                    Country: 'Russia'
                },
                title: 'SP-0005',
                value: 'Russia',
                icon: 'custom:custom26'
            },
            {
                location: {
                    City: 'Beijing',
                    Country: 'China'
                },
                title: 'SP-0006',
                value: 'China',
                icon: 'custom:custom26'
            },
            {
                location: {
                    City: 'Ottawa',
                    Country: 'Canada'
                },
                title: 'SP-0007',
                value: 'Canada',
                icon: 'custom:custom26'
            },
            {
                location: {
                    City: 'Rome',
                    Country: 'Italy'
                },
                title: 'SP-0008',
                value: 'Italy',
                icon: 'custom:custom26'
            },
            {
                location: {
                    City: 'Washington',
                    Country: 'USA'
                },
                title: 'SP-0009',
                value: 'USA',
                icon: 'custom:custom26'
            },
            {
                location: {
                    City: 'Brazil',
                    Country: 'Brazil'
                },
                title: 'SP-0010',
                value: 'Brazil',
                icon: 'custom:custom26'
            },
            {
                location: {
                    City: 'Buenos Aires',
                    Country: 'Argentina'
                },
                title: 'SP-0011',
                value: 'Argentina',
                icon: 'custom:custom26'
            }
        ]);
        component.set('v.markersTitle', 'Choose');
    },
    
    сearchTrips : function(component, event) {
        let action = component.get("c.getTrips");
        action.setParams({
            touristId : component.get("v.touristId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.trips", response.getReturnValue());
            } else if (state === "ERROR") {
                console.error("failed with state: " + state);
                const errors = action.getError();
                const errorMsg = (errors.length) ? errors[0].message : $A.get("$Label.c.TouristAssignmentErrorMsgGeneral");
                self.showToast("error", errorMsg);
            }
        });
        $A.enqueueAction(action); 
    },
    
    getTrip : function(component, event) {
        let action = component.get("c.getTrip");
        action.setParams({
            tripId : component.get("v.selectedTripId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.trip", response.getReturnValue());
            } else if (state === "ERROR") {
                console.error("failed with state: " + state);
                const errors = action.getError();
                const errorMsg = (errors.length) ? errors[0].message : $A.get("$Label.c.TouristAssignmentErrorMsgGeneral");
                self.showToast("error", errorMsg);
            }
        });
        $A.enqueueAction(action);
    },
    
    getCity : function(component, event) {
        let action = component.get("c.getNameCity");
        action.setParams({
            tripId : component.get("v.selectedTripId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.spacePoint", response.getReturnValue());
                component.set("v.city", response.getReturnValue().City__c);
            } else if (state === "ERROR") {
                console.error("failed with state: " + state);
                const errors = action.getError();
                const errorMsg = (errors.length) ? errors[0].message : $A.get("$Label.c.TouristAssignmentErrorMsgGeneral");
                self.showToast("error", errorMsg);
            } 
        });
        $A.enqueueAction(action);
        
    },
    
    createFlight: function(component, event) {
        let action = component.get("c.createFlight");
        action.setParams({
            tripId : component.get("v.selectedTripId"),
            touristId : component.get("v.touristId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                this.hideSpinner(component);
                const title =  $A.get("$Label.c.Success");
                const type = $A.get("$Label.c.Success");
                const message = $A.get("$Label.c.SuccessRegistTourists");
                this.showToast(title, type, message);
                $A.get('e.force:refreshView').fire();
                this.getDataForMap(component);
                this.сearchTrips(component, event);
            } else if (state === "ERROR") {
                console.error("failed with state: " + state);
                const errors = action.getError();
                const errorMsg = (errors.length) ? errors[0].message : $A.get("$Label.c.TouristAssignmentErrorMsgGeneral");
                self.showToast("error", errorMsg);
            } 
            this.hideSpinner(component);
        });
        $A.enqueueAction(action);
    },
    
    getWeather : function(component, event) {
        let action = component.get("c.fetchWeather");
        action.setParams({
            spacePoint : component.get("v.spacePoint").Id
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.temperature", response.getReturnValue().Average_Temperature__c);
            } else if (state === "ERROR") {
                console.error("failed with state: " + state);
                const errors = action.getError();
                const errorMsg = (errors.length) ? errors[0].message : $A.get("$Label.c.TouristAssignmentErrorMsgGeneral");
                self.showToast("error", errorMsg);
            }
            this.hideSpinner(component);
        });
        $A.enqueueAction(action);
    },
    
    zoomMap : function(component, event) {
        component.set("v.mapMarkers", [
            {
                location: {
                    City: component.get("v.city")
                },
            }
        ]);
        component.set("v.zoomLevel", 7);
    },
    
    showSpinner : function(component) {
        component.set("v.showSpinner", true);
    },
    
    hideSpinner : function(component) {
        component.set("v.showSpinner", false);
    },
    
    showToast : function(title, type, message) {
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(
            {
                title : title,
                type : type, 
                message : message
            }
        );
        toastEvent.fire();
    },
    
    getSiteWithPrice : function(component, event) {
        const touristId = component.get("v.touristId");
        window.open('https://price-space-tourism-developer-edition.ap24.force.com/?Id='+ touristId); 
    }
})