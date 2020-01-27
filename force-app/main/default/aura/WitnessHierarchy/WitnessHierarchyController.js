({
    init : function(component, event, helper) {
		var columns = [
			{ label: 'Name', fieldName: 'href', type: 'url', typeAttributes: { label: { fieldName: 'name' }}},
			{ label: 'Phone Number', fieldName: 'phone', type: 'phone' }
		];
		component.set('v.gridColumns', columns);
		helper.grabData(component);

		//Refresh data every 100 seconds
		// Not thrilled with this
		setInterval(function(){ helper.grabData(component); }, 10000);
	},

	handleSelect : function(component, event, helper) {
		event.preventDefault();
		console.log(event);
		component.set('v.selected', event.getParam('id'));
	}
})