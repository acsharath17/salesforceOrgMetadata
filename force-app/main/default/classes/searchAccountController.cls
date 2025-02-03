public class searchAccountController {
	@AuraEnabled
     public static List < account > fetchAccount(String searchKeyWord,Integer num) {
      String searchKey = searchKeyWord + '%';
      List < Account > returnList = new List < Account > ();
      //string qry = 'select id, Name, Type, Industry, Phone, Fax from account where Name = '+searchKeyWord+ ' LIMIT '+num;
      List < Account > lstOfAccount = [select id, Name, Type, Industry, Phone, Fax from account where Name LIKE: searchKey];
     //List < Account > lstOfAccount = database.query(qry);
      for (Account acc: lstOfAccount) {
       returnList.add(acc);
      }
      return returnList;
     }
}