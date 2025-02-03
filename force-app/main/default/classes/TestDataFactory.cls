public class TestDataFactory {
    public static Account createAccount(string Name, string type, string Industry){
        Account acc = new Account();
        acc.Name = Name;
        acc.Type = type;
        acc.Industry = Industry;
        insert acc;
        return acc;
    }
    
    public static contact createContact(id accountId, string firstName, string lastName, string email){
        Contact con = new Contact();
        con.AccountId = accountId;
        con.FirstName = firstName;
        con.LastName = lastName;
        con.Email = email;
        return con;
    }
    
    public static Search_Setting__c createSS(string name, string FTD, string FF){
        Search_Setting__c ss = new search_setting__c();
        ss.Name = name;
        ss.Fields_To_Display__c = FTD;
        ss.Filter_Fields__c = FF;
        insert ss;
        return ss;
    }
}