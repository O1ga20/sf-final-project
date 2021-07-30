({
    createСolumns : function(component) {
        let columns = [
            {
                label: "full name", 
                fieldName: "linkName", 
                type: "url", 
                typeAttributes: {
                    label: { fieldName: "Name" }, 
                    target: "_blank"}
            },
            {
                label : "email",
                fieldName : "Email__c",
                type : "email"
            },
            {
                label : "gender",
                fieldName : "Gender__c",
                type : "picklist"
            }
        ];
        component.set("v.columns", columns);
    },
    
    fetchTourists : function(component, event) {
        let action = component.get("c.getTourists");
        action.setParams({
            tripId : component.get("v.recordId"),
            recordLimit : component.get("v.initialRows"),
            recordOffset : component.get("v.rowNumberOffset")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                records.forEach(function(record) {
                    record.linkName = '/' + record.Id;
                });
                component.set("v.rows", records);  
                component.set("v.currentCount", component.get("v.initialRows"));
            }
            this.hideSpinner(component);
        });
        $A.enqueueAction(action);
    },
    
    getTotalNumTourists : function(component, event) {
        let action = component.get("c.getTotalNumTourists");
        action.setParams({
            tripId : component.get("v.recordId")
        });   
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS" ) {
                let resultData = response.getReturnValue();
                component.set("v.totalNumberOfRows", resultData);
            }
        });
        $A.enqueueAction(action);
    },
    
    getMoreTourists: function(component , rows){
        return new Promise($A.getCallback(function(resolve, reject) {
            let action = component.get("c.getTourists");
            let recordOffset = component.get("v.currentCount");
            let recordLimit = component.get("v.initialRows");
            action.setParams({
                tripId : component.get("v.recordId"),
                recordLimit : recordLimit,
                recordOffset : recordOffset 
            });
            action.setCallback(this, function(response) {
                let state = response.getState();
                if(state === "SUCCESS"){
                    let records = response.getReturnValue();
                    records.forEach(function(record) {
                        record.linkName = '/' + record.Id;
                    });
                    resolve(records);
                    recordOffset = recordOffset + recordLimit;
                    component.set("v.currentCount", recordOffset);   
                }                
            });
            $A.enqueueAction(action);
        }));
    },
    
    checkingTrip : function(component, event) {
        let numVacantSeats = component.get("v.trip.Free_Seats__c");
        let today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set("v.today", today);
        let isNotFlyAway = component.get("v.trip.Start_Date__c") > today;
        const isDisabledButton = !(numVacantSeats > 0 && isNotFlyAway);
        component.set("v.isButtonDisabled", isDisabledButton);
    },
    
    parametersValidation : function(component, event) {
        let selectedTourists = component.find("linesTable").getSelectedRows();
        component.set("v.selectedTourists", selectedTourists);
        let touristIds = selectedTourists.map(tourist => tourist.Id);
        component.set("v.touristIds", touristIds);
        let numberSelectedRows = selectedTourists.length;
        let numVacantSeats = component.get("v.trip.Free_Seats__c");
        if (numberSelectedRows != 0) {
            if (numVacantSeats > 0 && numVacantSeats >= numberSelectedRows) {
                this.hideSpinner(component);
                component.set("v.isTableOpen", false);
                component.set("v.isModalOpen", true);
            } else {
                this.hideSpinner(component);
                const title =  $A.get("$Label.c.Error");
                const type = $A.get("$Label.c.Error");
                const message = $A.get("$Label.c.TripErrorNotFreeSeats");
                this.showToast(title, type, message);
            }
        } else {
            this.hideSpinner(component);
            const title =  $A.get("$Label.c.Error");
            const type = $A.get("$Label.c.Error");
            const message = $A.get("$Label.c.TripErrorNull");
            this.showToast(title, type, message);
        }
        this.hideSpinner(component);
    },
    
    createFlights: function(component, event) {
        let action = component.get("c.createFlights");
        action.setParams({
            tripId : component.get("v.recordId"),
            touristIds : component.get("v.touristIds")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.isModalOpen", false);
                component.set("v.isTableOpen", false);
                this.hideSpinner(component);
                const title =  $A.get("$Label.c.Success");
                const type = $A.get("$Label.c.Success");
                const message = $A.get("$Label.c.SuccessRegistTourists");
                this.showToast(title, type, message);
            } 
            $A.get("e.force:closeQuickAction").fire();
        });
        $A.enqueueAction(action);
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
    }
})