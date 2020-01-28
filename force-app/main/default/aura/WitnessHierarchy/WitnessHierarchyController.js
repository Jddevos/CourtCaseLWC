({
    init : function(component, event, helper) {
		var columns = [
			{ label: 'Name', fieldName: 'href', type: 'url', typeAttributes: { label: { fieldName: 'name' }}},
			{ label: 'Phone Number', fieldName: 'phone', type: 'phone' }
		];
		component.set('v.gridColumns', columns);
		
		//Grab initial data
		helper.grabData(component);

		//Set up subscription to receive updates
		helper.subscribe(component, helper);
	},
})