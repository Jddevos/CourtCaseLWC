public with sharing class Witnesses {
    
	@AuraEnabled(cacheable=false)
	public static List<WrapperClass> getHierarchy(Id curCase){
		// System.debug('Getting object hierarchy');
		
		List<WrapperClass> wcList = new List<WrapperClass> ();

		// Get the accounts related to the current court case record
		List<Account_Case_Junction__c> junctionObjects = [SELECT Id, Account__c FROM Account_Case_Junction__c WHERE Court_Case__c = :curCase];
		List<Id> accountIdsToGrab = new List<Id> ();
		for (Account_Case_Junction__c acj : junctionObjects) {
			accountIdsToGrab.add(acj.Account__c);
		}

		// Pull in all of the account & contact information from those accounts
		List<Account> accountList = [SELECT Id, Name, Phone, (SELECT Id, Name, Phone FROM Contacts) FROM Account WHERE Id IN :accountIdsToGrab];

		//Map data to the wrapper class
		for (Account a : accountList) {
			WrapperClass wc = new WrapperClass();
			wc.name = a.Name;
			wc.id = a.Id;
			wc.href = '/' +a.Id;
			wc.phone = a.Phone;
			List<Item> iList = new List<Item> ();
			for (Contact c : a.Contacts) {
				Item i = new Item();
				i.name = c.Name;
				i.id = c.Id;
				i.href = '/' +c.Id;
				i.phone = c.Phone;
				iList.add(i);
			}
			wc.items = iList;
			wcList.add(wc);
		}

		// System.debug(wcList);
		return wcList;
	}

	public class WrapperClass {
		@AuraEnabled
		public Id id { get; set; }
		@AuraEnabled
		public String name { get; set; }
		@AuraEnabled
		public String href { get; set; }
		@AuraEnabled
		public String phone { get; set; }          
		@AuraEnabled
		public List<Item> items { get; set; }
	}

	public class Item {
		@AuraEnabled
		public Id id { get; set; }
		@AuraEnabled
		public String name { get; set; }
		@AuraEnabled
		public String href { get; set; }
		@AuraEnabled
		public String phone { get; set; }
	}
}