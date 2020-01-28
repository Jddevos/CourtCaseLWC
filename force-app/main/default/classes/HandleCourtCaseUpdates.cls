public with sharing class HandleCourtCaseUpdates {

	public static void fireEvents(List<Account> accounts) {
		// System.debug('Creating event');
		List<Hierarchy_Content_Update__e> eventList = new List<Hierarchy_Content_Update__e> ();
		for (Account a : accounts) {
			Hierarchy_Content_Update__e hcu = new Hierarchy_Content_Update__e();
			hcu.Id__c = a.Id;
			hcu.Name__c = a.Name;
			hcu.Phone__c = a.Phone;
			eventList.add(hcu);
		}

		List<Database.SaveResult> results = EventBus.publish(eventList);
		// System.debug(results);
	}

	public static void fireEvents(List<Contact> contacts) {
		// System.debug('Creating event');
		List<Hierarchy_Content_Update__e> eventList = new List<Hierarchy_Content_Update__e> ();
		for (Contact c : contacts) {
			System.debug(c.Name);
			Hierarchy_Content_Update__e hcu = new Hierarchy_Content_Update__e();
			hcu.Id__c = c.Id;
			hcu.Name__c = c.FirstName+ ' ' +c.LastName;
			hcu.Phone__c = c.Phone;
			eventList.add(hcu);
		}

		if (eventList.size() > 0) {
			List<Database.SaveResult> results = EventBus.publish(eventList);
			// System.debug(results);
		}
	}
}
