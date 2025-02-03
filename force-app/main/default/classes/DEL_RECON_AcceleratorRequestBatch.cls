/**
* @author        Nancy Gupta / Apurva Agarwal 
* @date          16/06/2018
* @description   Batch class that performs the reconciliation for the query that is passed in csv file
* @name          DEL_RECON_AcceleratorRequestBatch 
*/

global class DEL_RECON_AcceleratorRequestBatch implements Database.batchable<String>,Database.stateful{
    global List<String> queryListLine = new List<String>();
    global String recreateCSV = '';
    global String actualCSV = '';
    global ID parentID;
    global String csvFileName = '';
    global integer queryColumnNumber = 0;
    global integer queryDeltaColumnNumber = 0;
    global Boolean queryDeltaFlag = False;
    public DEL_RECON_AcceleratorRequestBatch(string csvAsString, ID parentRecID,String FileName){
        List<String> csvFileLines = new List<String>();
        Integer counter = 0;
        actualCSV = csvAsString;
        parentID = parentRecID;
        csvFileName = FileName;
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
        }
        if(parentID != Null){
            DEL_RECON_Accelerator__c recon = [Select ID,Name,Column_Number__c ,Source_Count_Column_Number__c,Perform_Source_Target_Delta__c
                                                from DEL_RECON_Accelerator__c where ID=:parentID];
            if(recon != Null && recon.Column_Number__c != Null){
                queryColumnNumber = Integer.ValueOf(recon.Column_Number__c);
                if(queryColumnNumber > 0){
                    queryColumnNumber = queryColumnNumber - 1;    //calculating the index number
                }
            }
            if(recon != Null && recon.Perform_Source_Target_Delta__c && recon.Source_Count_Column_Number__c != Null){
                queryDeltaFlag = True;
                queryDeltaColumnNumber = Integer.ValueOf(recon.Source_Count_Column_Number__c);
                if(queryDeltaColumnNumber > 0){
                    queryDeltaColumnNumber = queryDeltaColumnNumber - 1;    //calculating the index number
                }
            }
        }
    }
    
    global Iterable<String> Start(Database.BatchableContext BC){
        return queryListLine;
    }
   
    global void execute(Database.BatchableContext BC, List<String> queryListLine){
        Integer recordsSearchedCount = 0;
        List<String> queryList = new List<String>();
        String queryError = '';
        String str = '';
        Integer SourceVal = 0;
        Integer DeltaVal = 0;
        try{
            for(String s: queryListLine){
                integer iCol = queryColumnNumber;
                Integer deltaCol = queryDeltaColumnNumber;
                /*System.debug('hey>>queryListLine>>>'+s);
                s = s.replaceAll('\'', '\\\\\'');
                
                System.debug('hey>>queryListLine>>>'+s);
                Integer sLength = s.length();
                System.debug('hey>>sLength >>>'+sLength);
                List<String> parts = new List<String>();
                for(i=0;i<sLength-1;i++){
                s.substring(i,i+1);                
                }
                //if()*/
                
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
                strQ2 = strQ1.removeStart(', ').Split(',')[iCol].trim();
                queryList.add(strQ2.replaceAll('==Comma==','\\,'));
                if(queryDeltaFlag == True){
                    String deltastrQ2 = '';
                    deltastrQ2 = strQ1.removeStart(', ').Split(',')[deltaCol].trim();
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
                str = str +','+ 'Error: ' +queryError + ',' + '';
                queryError = '';
            }
            recreateCSV = recreateCSV + str + '\n';
        }
    }
    
    global void finish(Database.BatchableContext BC){
        DEL_RECON_Accelerator__c rec = new DEL_RECON_Accelerator__c();
        rec.ID = parentID;
        
        Attachment detailReportCSVAttachment;
        detailReportCSVAttachment = new Attachment();
        detailReportCSVAttachment.Body = Blob.valueof(recreateCSV);
        detailReportCSVAttachment.Name = csvFileName ;                        
        detailReportCSVAttachment.parentId = parentID;
        detailReportCSVAttachment.ContentType = 'text/csv; charset=UTF-8';
        if(detailReportCSVAttachment!= Null ){
            rec.Status__c = 'Completed';
            insert detailReportCSVAttachment;
        }
        else{
            rec.Status__c = 'Error';
        }
        if(rec != Null && rec.ID != Null){
            update rec;
        }
        String emailaddress = UserInfo.getUserEmail();
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new list<string> {emailaddress };
        String subject ='Reconciliation Report Completed : ' +system.now();
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm()+'/'+rec.id;
        
        email.setHtmlBody('Dear User,<br><br> Please be informed that the request for reconciliation is now completed.<br>Please click on the link to access report.<br> <a href="'+fullFileURL+'"> Link </a> <br><br>Thanks, <br> System Admin ');
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}