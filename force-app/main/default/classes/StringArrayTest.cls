public class StringArrayTest {

    //Public Method
    public static void generateStringArray(Integer length) {

        //Instantiate the list
        String[] myArray = new List<String>(length);
		system.debug('AAAAAAAAAAAAA'+myArray.size());
        system.debug('BBBBBBBBBBBBB'+myArray);
        //Iterate throught the list
        for(Integer i=0;i<myArray.size();i++) {

            //Populate the array
            myArray.add(myArray[i]);

            // Write value to the debug log
            System.debug(myArray[i]);

        } //end loop

    }//end method       
 }// end class