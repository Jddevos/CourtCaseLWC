@isTest
private class Test_Witnesses {
    @TestSetup
	static void makeData(){
		Account clientAccount = new Account();
		clientAccount.Name = 'Test Client Account';
		clientAccount.Phone = '123-456-7890';

		Account witnessAccount = new Account();
		witnessAccount.Name = 'Test Witness Account';
		witnessAccount.Phone = '123-456-7890';
		
		List<Account> accountsToInsert = new List<Account>();
		accountsToInsert.add(clientAccount);
		accountsToInsert.add(witnessAccount);
		insert accountsToInsert;

		Contact clientContact = new Contact();
		clientContact.LastName = 'TestClient';
		clientContact.Phone = '098-765-4321';

		Contact witnessContact = new Contact();
		witnessContact.LastName = 'TestWitness';
		witnessContact.phone = '555-666-7777';
		witnessContact.accountId = witnessAccount.Id;

		List<Contact> contactsToInsert = new List<Contact>();
		contactsToInsert.add(clientContact);
		contactsToInsert.add(witnessContact);
		insert contactsToInsert;

		Court_Case__c cc = new Court_Case__c();
		cc.Client__c = clientAccount.Id;
		insert cc;
		
		Account_Case_Junction__c acj = new Account_Case_Junction__c();
		acj.Account__c = witnessAccount.Id;
		acj.Court_Case__c = cc.Id;
		insert acj;
	}

	@isTest
	static void testDataUpdate() {
		Contact c = [SELECT Id, Phone FROM Contact WHERE LastName = 'TestWitness' LIMIT 1];
		c.Phone = '555-666-7778';
		update c;

		Account a = [SELECT Id, Phone FROM Account WHERE Name = 'Test Client Account' LIMIT 1];
		a.Phone = '098-765-4322';
		update a;
	}

	@isTest
	static void testGetHierarchy() {
		List<Witnesses.WrapperClass> wc = Witnesses.getHierarchy([SELECT Id FROM Court_Case__c LIMIT 1].Id);
		System.assertEquals(1, wc.size());	//There is only 1 witness account, so only one should return
	}
}