global class g_CustomLookupController {
	public List<Contact> contact_results {get;set;} // search results
	public List<Contact> contact_results1{get;set;} // search results for FirstName
	public List<Contact> contact_results2{get;set;} // search results for LastName
	public List<Contact> contact_results3{get;set;} // search results for Email

	public List<Account> account_results {get;set;} // search results
	public List<Lead> lead_results {get;set;} // search results
	public List<Lead> lead_results1{get;set;} // search results for FirstName
	public List<Lead> lead_results2{get;set;} // search results for LastName
	public List<Lead> lead_results3{get;set;} // search results for Email

	public string searchString {get;set;} // search keyword, set either by invoking page or via URI
	public string firstName {get;set;} // set by invoking page
	public string lastName {get;set;} // set by invoking page
	public string email {get;set;} // set by invoking page
	
	public static string ixnId {get;set;} // interaction id, set via URI
	public string inServiceCloudConsole {get;set;} // set in constructor
	
	public g_CustomLookupController() {
		// get the current search string
		searchString = System.currentPageReference().getParameters().get('lksrch');
		ixnId = System.currentPageReference().getParameters().get('ixnId');
		inServiceCloudConsole = System.currentPageReference().getParameters().get('inServiceCloudConsole');
		system.debug('*** CustomLookupController ixnId ' + ixnId);
		system.debug('*** CustomLookupController inServiceCloudConsole '+inServiceCloudConsole);
		system.debug('*** CustomLookupController search for '+searchString);      
		
		if (searchString != '' && searchString != null) {
			runSearch();  
		}
	}
   
	// performs the keyword search
	global PageReference search() {
		system.debug('*** search');
		runSearch();
		return null;
	}
    
  
	// prepare the query and issue the search command
	private void runSearch() {
		system.debug('*** runSearch');
		performSearch(searchString);         
	} 
  
  
	// run the search and save the records found. 
	private void performSearch(string searchString) {
		system.debug('*** performSearch for ' + searchString);
		/*
		String soql = 'select id, name from contact';
		if (searchString != '' && searchString != null) {
			//soql = soql +  ' where name LIKE \'%' + searchString +'%\'';
			soql = soql +  ' where phone LIKE \'%' + searchString +'%\'';      
		}
		soql = soql + ' limit 25';
		System.debug(soql);
		return database.query(soql);
		*/
		List<List<SObject>> objs = null;
		contact_results = new List<Contact>();
		contact_results1 = null;
		contact_results2 = null;
		contact_results3 = null;
		Integer listSize = 0;
		
		system.debug('*** firstName = ' + firstName);
		system.debug('*** lastName = ' + lastName);
		system.debug('*** email = ' + email);

		if (searchString != null && searchString != '') {
			objs = [find :searchString in phone fields returning Contact(Account.Name, Id, 
					Name, FirstName, LastName, 
					MailingStreet, 
					EMail, 
					Phone, MobilePhone, HomePhone, AssistantPhone, OtherPhone)];
			listSize = objs.size();
			system.debug('*** contact listSize = ' + listSize);
			List<Contact> contacts = null;
			if (!objs.isEmpty()) {
				contact_results.addAll((List<Contact>) objs[0]);
			}
		} 
		system.debug('*** contact_results= ' + contact_results);
		
		try {
			if (firstName != null && firstName != '') {
				string term = '%' + firstName + '%'; 
				List<Contact> contact_results1 = [select  Account.Name, Id, 
						Name, FirstName, LastName, 
						MailingStreet, 
						EMail,
						Phone, MobilePhone, HomePhone, AssistantPhone, OtherPhone 
						from contact where FirstName like :term];
				system.debug('*** contact listSize1 = ' + contact_results1.size());
				system.debug('*** contact_results1 = ' + contact_results1);
				contact_results.addAll(contact_results1);
			}

			if (lastName != null && lastName != '') {
				string term = '%' + lastName + '%';    		
				List<Contact> contact_results2 = [select Account.Name, Id, 
						Name, FirstName, LastName, 
						MailingStreet, 
						EMail,
						Phone, MobilePhone, HomePhone, AssistantPhone, OtherPhone 
						from contact where LastName like :term];
				system.debug('*** contact listSize2 = ' + contact_results2.size());
				system.debug('*** contact_results2 = ' + contact_results2);
				contact_results.addAll(contact_results2);
			} 
			
			if (email != null && email != '') {
				string term = '%' + email + '%';
				List<Contact> contact_results3 = [select Account.Name, Id, 
						Name, FirstName, LastName, 
						MailingStreet, 
						EMail,
						Phone, MobilePhone, HomePhone, AssistantPhone, OtherPhone 
						from contact where Email like :term];
				system.debug('*** contact listSize3 = ' + contact_results3.size());
				system.debug('*** contact_results3 = ' + contact_results3);
				contact_results.addAll(contact_results3);
			}         
			system.debug('*** TOTAL contact_results= ' + contact_results);

			/*
			// Use default sorting
			if (contact_results.size() != 0) {
				Set<Contact> myset = new Set<Contact>();
				List<Contact> myresult = new List<Contact>();
				//this removes the duplicates since list is not allowed dups
				myset.addAll(contact_results);
				myresult.addAll(myset);
				contact_results = myresult;
				contact_results.sort();
			}
			*/

			// Use custom sorting
			if (contact_results.size() != 0) {
				Set<Contact> myset = new Set<Contact>();
				List<g_ContactWrapper> myresult = new List<g_ContactWrapper>();
				//this removes the duplicates since list is not allowed dups
				myset.addAll(contact_results);
				for (Contact c : myset) {
					myresult.add(new g_ContactWrapper(c));
				}
				myresult.sort();

				contact_results.clear();
				for (g_ContactWrapper g_c : myresult) {
					contact_results.add(g_c.getContact());
				}
			}
		}
		catch (QueryException e) {
			system.debug('*** ERROR = ' + e); 
		}
		
		if (searchString != null && searchString != '') {
			objs = [FIND :searchString IN PHONE FIELDS RETURNING Account(Id, Name, Phone)];

			listSize = objs.size();
			system.debug('*** account listSize = ' + listSize);
			List<Account> accounts = null;
			if (!objs.isEmpty()) {
				account_results = ((List<Account>)objs[0]);
			}
		}
		system.debug('*** contact_results = ' + contact_results);  
    
    
    	lead_results = new List<Lead>();
		if (searchString != null && searchString != '') { 
			//Error "field not recognized" when using Address in query   
			objs = [FIND :searchString IN PHONE FIELDS RETURNING Lead(Id, ConvertedAccountId, 
					Name, Street, FirstName, LastName, Email, Phone, MobilePhone)];
			listSize = objs.size();
			system.debug('*** lead listSize = ' + listSize);
			List<Lead> leads = null;
			if (!objs.isEmpty()) {
				lead_results = ((List<Lead>)objs[0]);
			}
		}
		system.debug('*** lead_results = ' + lead_results);
		
		lead_results1 = null;
		lead_results2 = null;
		lead_results3 = null;	
	
		if (searchString != null && searchString != '') { 
			//Error "field not recognized" when using Address in query   
			objs = [FIND :searchString IN PHONE FIELDS RETURNING Lead(Id, ConvertedAccountId, 
					Name, Street, FirstName, LastName, Email, Phone, MobilePhone)];
			listSize = objs.size();
			system.debug('*** lead listSize = ' + listSize);
			List<Lead> leads = null;
			if (!objs.isEmpty()) {
				lead_results = ((List<Lead>)objs[0]);
			}
		}		
		
		try {
			if (firstName != null && firstName != '') {
				string term = '%' + firstName + '%'; 
				List<Lead> lead_results1 = [select Id, ConvertedAccountId, 
					Name, Street, FirstName, LastName, Email, Phone, MobilePhone from Lead where FirstName like :term];
				system.debug('*** lead listSize1 = ' + lead_results1.size());
				system.debug('*** lead_results1 = ' + lead_results1);
				lead_results.addAll(lead_results1);
			}

			if (lastName != null && lastName != '') {
				string term = '%' + lastName + '%';    		
				List<Lead> lead_results2 = [select Id, ConvertedAccountId, 
					Name, Street, FirstName, LastName, Email, Phone, MobilePhone from Lead where LastName like :term];
				system.debug('*** lead listSize2 = ' + lead_results2.size());
				system.debug('*** lead_results2 = ' + lead_results2);
				lead_results.addAll(lead_results2);
			} 
			
			if (email != null && email != '') {
				string term = '%' + email + '%';
				List<Lead> lead_results3 = [select Id, ConvertedAccountId, 
					Name, Street, FirstName, LastName, Email, Phone, MobilePhone from Lead where Email like :term];
				system.debug('*** lead listSize3 = ' + lead_results3.size());
				system.debug('*** lead_results3 = ' + lead_results3);
				lead_results.addAll(lead_results3);
			}         
			system.debug('*** TOTAL lead_results= ' + lead_results);

			// Use default sorting
			if (lead_results.size() != 0) {
				Set<Lead> myset = new Set<Lead>();
				List<Lead> myresult = new List<Lead>();
				//this removes the duplicates since list is not allowed dups
				myset.addAll(lead_results);
				myresult.addAll(myset);
				lead_results = myresult;
				lead_results.sort();
			}
		}
		catch (QueryException e) {
			system.debug('*** ERROR = ' + e); 
		}
	}
  
  
	// used by the visualforce page to send the link to the right dom element
	public string getFormTag() {
		return System.currentPageReference().getParameters().get('frm');
	}
  
	// used by the visualforce page to send the link to the right dom element for the text box
	public string getTextBox() {
		return System.currentPageReference().getParameters().get('txt');
	}
}