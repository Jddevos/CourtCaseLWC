({
    grabData : function(component) {
		var action = component.get('c.getHierarchy');
		action.setParams({curCase : component.get("v.recordId")});
		action.setCallback(this, function(response) {
			console.log(response.getState());
			console.log(response.getReturnValue());
			component.set("v.hierarchyList", response.getReturnValue());
		});
		$A.enqueueAction(action);
    }
})