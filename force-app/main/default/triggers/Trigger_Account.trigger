trigger Trigger_Account on Account (after insert, after update) {
	if (Trigger.isBefore) {

	}
	if (Trigger.isAfter) {
		if (Trigger.isInsert) {
			HandleCourtCaseUpdates.fireEvents(Trigger.new);
		}
		if (Trigger.isUpdate) {
			HandleCourtCaseUpdates.fireEvents(Trigger.new);
		}
	}
}