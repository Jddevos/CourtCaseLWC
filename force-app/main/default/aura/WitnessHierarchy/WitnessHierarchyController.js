({
    init : function(component, event, helper) {
		helper.grabData(component);
		setInterval(function(){helper.grabData(component);}, 10000);
	},

	handleSelect : function(component, event, helper) {
		event.preventDefault();
		console.log(event);
		component.set('v.selected', event.getParam('id'));
	}
})