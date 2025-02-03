public class searchAccountController_v2 {
	@AuraEnabled
     public static List < sObject > fetchAccount(String searchKeyWord,string fields, string objectName) {
      String searchKey = searchKeyWord + '%';
      List < sObject > returnList = new List < sObject > ();
      string qry = 'Select '+fields+ ' from '+objectName;
      List < sObject > lstOfAccount = database.query(qry);
     
      for (sObject acc: lstOfAccount) {
       returnList.add(acc);
      }
      return returnList;
     }
}