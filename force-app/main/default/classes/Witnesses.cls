public with sharing class Witnesses {
    
	@AuraEnabled(cacheable=false)
	public static List<WrapperClass> getHierarchy(Id curCase){
		System.debug('Getting object hierarchy');
		
		List<WrapperClass> wcList = new List<WrapperClass> ();

		List<Account_Case_Junction__c> junctionObjects = [SELECT Id, Account__c FROM Account_Case_Junction__c WHERE Court_Case__c = :curCase];
		List<Id> accountIdsToGrab = new List<Id> ();
		for (Account_Case_Junction__c acj : junctionObjects) {
			accountIdsToGrab.add(acj.Account__c);
		}
		List<Account> accountList = [SELECT Id, Name, Phone, (SELECT Id, Name, Phone FROM Contacts) FROM Account WHERE Id IN :accountIdsToGrab];

		for (Account a : accountList) {
			WrapperClass wc = new WrapperClass();
			wc.label = a.Name;
			wc.name = a.Name;
			wc.href = '/' +a.Id;
			wc.metatext = a.Phone;
			wc.expanded = true;
			List<Item> iList = new List<Item> ();
			for (Contact c : a.Contacts) {
				Item i = new Item();
				i.label = c.Name;
				i.name = c.Name;
				i.href = '/' +c.Id;
				i.metatext = c.Phone;
				iList.add(i);
			}
			wc.items = iList;
			wcList.add(wc);
		}

		System.debug(wcList);
		return wcList;
	}

	public class WrapperClass {
		@AuraEnabled
		public String label { get; set; }
		
		@AuraEnabled
		public String name { get; set; }

		@AuraEnabled
		public String href { get; set; }

		@AuraEnabled
		public String metatext { get; set; }

		@AuraEnabled
		public Boolean expanded { get; set; }              

		@AuraEnabled
		public List<Item> items { get; set; }
	}

	public class Item {
		@AuraEnabled
		public String label { get; set; }
		
		@AuraEnabled
		public String name { get; set; }

		@AuraEnabled
		public String href { get; set; }

		@AuraEnabled
		public String metatext { get; set; }

		@AuraEnabled
		public Boolean expanded { get; set; }
	}
}