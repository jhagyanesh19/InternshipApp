({
    handleSearch: function (component, event, helper) {
        var searchText = component.get("v.searchText").toLowerCase();
        
        // Call the Apex controller method to fetch Internship__c records
        var action = component.get("c.getInterships");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var internships = response.getReturnValue();
                var filteredData = [];

                internships.forEach(function (item) {
                    if (
                        item.Name.toLowerCase().includes(searchText) ||
                        item.InternshipStartDate__c.toLowerCase().includes(searchText) ||
                        item.InternshipEndDate__c.toLowerCase().includes(searchText)
                    ) {
                        filteredData.push(item);
                    }
                });
                console.log(v.internships)

                // Update the displayed data
                component.set("v.internships", filteredData);
            }
        });
        $A.enqueueAction(action);
    }
})