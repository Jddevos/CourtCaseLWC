({
	grabData : function(component) {
		var action = component.get('c.getHierarchy');
		action.setParams({curCase : component.get("v.recordId")});
		action.setCallback(this, function(response) {
			// console.log(response.getState());
			if (response.getState() === "SUCCESS") {
				// Handle data
				var data = response.getReturnValue();
				var data = JSON.parse(JSON.stringify(response.getReturnValue()).split('items').join('_children'));

				// console.log(data);
				component.set('v.gridData', data);
			} else if (response.getState() === "INCOMPLETE" || response.getState() === "ERROR") {
				// Handle errors
				console.log('An error has occurred with data retrieval');
				console.log(response.getReturnValue());

				var toastEvent = $A.get("e.force:showToast");
				toastEvent.setParams({
					"title": "Error in data retrieval",
					"message": response.getReturnValue(),
					"type": "error"
				});
				toastEvent.fire();
			}
		});
		$A.enqueueAction(action);
	},

	subscribe : function(component, helper) {
		const empApi = component.find('empApi');
		const channel = component.get('v.channel');
		const replayId = -1;
		const callback = function(message) {
			// console.log('Event Received : ' + JSON.stringify(message));
			helper.grabData(component);
		}
		empApi.subscribe(channel, replayId, $A.getCallback(callback)).then($A.getCallback(function (newSubscription) {
			// console.log('Subscribed to channel ' +channel);
			component.set('v.subscription', newSubscription);
		}));
	},
})