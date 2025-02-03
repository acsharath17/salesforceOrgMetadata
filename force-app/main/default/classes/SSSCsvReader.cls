/**
 * Used to read a delimited file.
 */
global class SSSCsvReader {
    
    global List<String> queryListLine = new List<String>();
    global String recreateCSV = '';
    global String actualCSV = '';
    global ID parentID;
    global String csvFileName = '';
    global integer queryColumnNumber = 0;
    global integer queryDeltaColumnNumber = 0;
    global Boolean queryDeltaFlag = False;
    global blob attachmentFile;
    global string csvAsString;
    global string finalString = '';
    global string[] finalLines = new string[]{};

    public SSSCsvReader() {
        List<Attachment> att = [Select id,Body from Attachment Where ParentId =: ApexPages.CurrentPage().getParameters().get('Id')];
        /*if(!att.isEmpty()){
            attachmentFile = att[0].body;
            csvAsString = attachmentFile.toString();
            
        }
        csvAsString = fileBody;
        
        List<String> csvFileLines = new List<String>();
        Integer counter = 0;
        actualCSV = csvAsString;
        //parentID = parentRecID;        
        csvAsString = csvAsString.removeStart('(');
        csvAsString = csvAsString.removeEnd(')');
        csvFileLines = csvAsString.split('\r\n');
        
        for(String str: csvFileLines){
            if(counter>0){
                queryListLine.add(str.escapeCsv()); //replaceAll('[\n]', ' ').
                System.debug('hey>>str>>>'+str);
            }
            if(counter==0){
                counter = counter +1;
                
                recreateCSV = (str.split('\n')[0]).replaceAll('[\n\r]', '')+','+'RECON Result' +','+'RECON Delta'+ '\n';
            }
        }*/
        
        //finalstring = csvData();
    }
    
    public void callButton(){
        //string xyz = csvData();
    }
    
    public string[] csvData(string fileBody){
        system.debug('fileBody-------'+fileBody);
        csvAsString = fileBody;
        
        List<String> csvFileLines = new List<String>();
        Integer counter1 = 0;
        actualCSV = csvAsString;
        //parentID = parentRecID;        
        csvAsString = csvAsString.removeStart('(');
        csvAsString = csvAsString.removeEnd(')');
        try{
            csvFileLines = csvAsString.split('\n');
        }catch(exception e){
            csvFileLines = csvAsString.split('\r\n');
        }
        
        
        system.debug('cscline size---------'+csvFileLines.size());
        for(String str: csvFileLines){
            if(counter1>0){
                queryListLine.add(str.escapeCsv()); //replaceAll('[\n]', ' ').
                System.debug('hey>>str>>>'+str);
            }
            if(counter1==0){
                counter1 = counter1 +1;
                
                //recreateCSV = (str.split('\n')[0]).replaceAll('[\n\r]', '')+','+'RECON Result' +','+'RECON Delta'+ '\n';
                recreateCSV = (str.split('\n')[0]).replaceAll('[\n\r]', '')+','+'\n';
            }
        }
    
        Integer recordsSearchedCount = 0;
        List<String> queryList = new List<String>();
        String queryError = '';
        String str = '';
        Integer SourceVal = 0;
        Integer DeltaVal = 0;
        try{
            for(String s: queryListLine){
                integer iCol = 0;
                Integer deltaCol = 0;
                
                
                s = s.replaceAll('""', '==tag====check==');
                String[] parts = s.split('==tag==');
                String strQ1 = '';
                integer counter = 0;
                String str1 = '';
                for(integer i=0;i<parts.size();i++){
                    str1 = '';
                    if(parts[i].contains('==check==')){
                        counter = counter+1;
                        IF(System.Math.MOD(counter, 2) == 0){
                            str1 = parts[i].removeStart('==check==');
                            strQ1 = strQ1 + str1;
                        }
                        else{
                            str1 = parts[i].removeStart('==check==');
                            str1 = str1.replaceAll('\\,','==Comma==');
                            strQ1 = strQ1 + str1;
                        }
                    }
                    else{
                        strQ1 = strQ1 + parts[i];
                    }
                }
                String strQ2 = '';
                //strQ2 = strQ1.removeStart(', ').Split(',')[iCol].trim();
                queryList.add(strQ2.replaceAll('==Comma==','\\,'));
                if(queryDeltaFlag == True){
                    String deltastrQ2 = '';
                    //deltastrQ2 = strQ1.removeStart(', ').Split(',')[deltaCol].trim();
                    deltastrQ2 = deltastrQ2.replaceAll('==Comma==','\\,');
                    SourceVal = Integer.ValueOf(deltastrQ2);
                }
                //queryList.add(s.removeStart(', ').Split(',')[i].trim());
                System.debug('hey>>queryList>>>'+queryList);
                System.debug('hey>>SourceVal>>>'+SourceVal +queryDeltaFlag );
            }
            for(String strQ: QueryList){
                System.debug('hey>>strQ>>>'+strQ);
                AggregateResult aggregateData2;
                
                if(strQ != ''){
                    //strQ = strQ.replaceAll('[\n]', ' ');
                    strQ = strQ.replaceAll('[\r\n]', ' ');
                    strQ = strQ.replaceAll('count\\(\\)', 'count(id)');
                    strQ = strQ.replaceAll('count\\(\\*\\)', 'count(id)');
                    //strQ = strQ.replaceAll('""', '"');
                    strQ = strQ.replaceAll('""', '');
                }
                
                if(strQ == ''){
                    //Do Nothing
                }
                else if(strQ.containsIgnoreCase(' LIMIT ')){
                    aggregateData2 = Database.query(strQ);
                }
                else if(!strQ.containsIgnoreCase(' COUNT(') && !strQ.containsIgnoreCase(' SUM(') && !strQ.containsIgnoreCase(' MAX(') && !strQ.containsIgnoreCase(' MIN(') && !strQ.containsIgnoreCase(' COUNT_DISTINCT(') && !strQ.containsIgnoreCase(' AVG(') ){
                    string strQ2 = strQ + ' Limit 1';
                    aggregateData2 = Database.query(strQ2);
                }
                else{
                    string strQ2 = strQ;
                    aggregateData2 = Database.query(strQ2);
                }
                
                for(AggregateResult aggregateData : Database.query(strQ)){
                    recordsSearchedCount = (Integer)aggregateData.get('expr0');
                }
                if(recordsSearchedCount != Null && queryDeltaFlag == True){
                    DeltaVal = SourceVal - recordsSearchedCount;
                }
            }
        }
        catch(Exception e){
            //queryError = e.getMessage(); 
            queryError =  e + '' ; 
            queryError = queryError.replace(',',' ');
        }
        for(String s: queryListLine){
            str = s.unescapecsv();//(s.split('\n')[0]).replaceAll('[\n\r]', '').unescapecsv();
            if(queryError == ''){
                if(queryDeltaFlag == True){
                    str = str +','+ recordsSearchedCount + ',' + DeltaVal;
                }
                else{
                    str = str +','+ recordsSearchedCount;
                }
            }
            else{
                //str = str +','+ 'Error: ' +queryError + ',' + '';
                queryError = '';
            }
            system.debug('str----------'+str);
            recreateCSV = recreateCSV + str + '\n';
            str = str.replaceAll('\n',' ');
            finalLines.add(str);
            system.debug('recreateCSV-------'+recreateCSV);
        }
        system.debug('recreateCSV222222-------'+finalLines);
        return finalLines;
    }
    
    
}