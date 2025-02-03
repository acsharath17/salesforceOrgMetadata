public class reconReport_Controller {
    
    
    public String[] picklistValues = new String[]{};
    Public List<String> leftSelected {get;set;}
    Public List<String> rightSelected {get;set;}
    Set<String> leftValues = new Set<String>();
    Set<String> rightValues = new Set<String>();
    public set<string> tableHeaders{get;set;}
    public blob attachmentFile;
    public string[] csvLines = new string[]{};
    public string[] finalLines = new string[]{};
    public string allLines;
    List<EachRow> allListOfRecords = new List<EachRow>();
    public TargetTable TargetTable_inst {get;set;}
    public map<Integer,List<string>> finalTableValues {get;set;}
    public Boolean displayPopup {get;set;}
    
    public Id contactId;
    public Integer attendedCount{get;set;}
    public Integer partialCount{get;set;}
    public Integer absentCount{get;set;} 

     
    public reconReport_Controller(){
        
        attendedCount = 50;
        partialCount = 30;
        absentCount = 20;
        User loggedInUser = [Select Id,contactId FROM User WHERE ID=:userinfo.getUserId()];
        contactId = loggedInUser.contactId;
        
        tableHeaders = new set<string>();
        List<Attachment> att = [Select id,Body from Attachment Where ParentId =: ApexPages.CurrentPage().getParameters().get('Id') AND ( ContentType = 'text/csv; charset=UTF-8' OR ContentType = 'application/vnd.ms-excel') ORDER BY CreatedDate];
        if(!att.isEmpty()){
            attachmentFile = att[0].body;
            allLines = attachmentFile.toString();
            csvLines = allLines.split('\n');
            system.debug('allLines++++++++++ '+allLines);
            SSSCsvReader cc = new SSSCsvReader();
            finalLines = cc.csvData(attachmentFile.toString());
        }
        leftSelected = new List<String>();
        rightSelected = new List<String>();
        system.debug('************** '+csvLines[0]);
        system.debug('-------------- '+csvLines[0].split(','));
        picklistValues = csvLines[0].split(',');
        system.debug('picklistValues----------'+picklistValues.size());
        leftValues.addAll(picklistValues);
    }
    
    public pagereference goNext(){
        PageReference OpenNewPage = Page.googleChart;
        //system.debug();
        return OpenNewPage;
    }
    
    public void showPopup()
    {
        
    displayPopup = true;

    
    }
    
    public void closePopup() {
        displayPopup = false;
        
    }
    
    public pagereference dataForTable(){
        
        finalTableValues = new map<Integer,list<String>>();
        TargetTable_inst = new TargetTable();
        
        
        
        for(Integer i=0 ; i < finalLines.size() ; i++){
            string line = finalLines[i].remove(',');
            //string line = finalLines[i];
            system.debug('line------------'+finalLines[i]);
            List<String> requiredColumns = new List<String>();
            string[] csvrow = new string[]{};
            if(!string.isBlank(line)){
                EachRow er = new EachRow();
                if(line.contains('"')){
                    system.debug('Inside comma');
                    csvrow = removeComma(finalLines[i],picklistValues.size());
                }else{
                    csvrow = finalLines[i].split(',');
                }
                system.debug('Row Data+++++++++++'+csvrow);
                system.debug('Row Data-----------'+csvrow.size());
                string requiredData = '';
                List<String> TH = new List<String>();
                TH.addAll(tableHeaders);
                system.debug('Header-------'+TH);
                for(integer j=0 ; j < TH.size() ; j++){
                    integer ind = picklistValues.indexOf(TH[j]);
                    system.debug('index------'+ind);
                    system.debug('Index Data---'+csvrow[ind]);
                    //requiredData = requiredData + ' ' +csvrow[ind] +',';
                    requiredColumns.add(csvrow[ind]);
                }
                
                
                er.rowValue = requiredColumns;
                allListOfRecords.add(er);
                finalTableValues.put(i,requiredColumns); 
                
                system.debug('Columns+++++ '+requiredColumns);
                system.debug('Map+++++++++ '+finalTableValues);
            }                                   
        }
        
        return null;    
    }
    
    public PageReference getSelect(){
        rightSelected.clear();
        for(String s : leftSelected){
            leftValues.remove(s);
            rightValues.add(s);
        }
        return null;
    }
     
    public PageReference getDeselect(){    
        leftSelected.clear();
        for(String s : rightSelected){
            rightValues.remove(s);
            leftValues.add(s);
        }
        return null;
    }
     
    public List<SelectOption> getDeselectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<String> objList = new List<String>();
        objList.addAll(leftValues);
        objList.sort();
        for(String s : objList){
            options.add(new SelectOption(s,s));
        }
        return options;
    }
     
    public List<SelectOption> getSelectedValues(){
         
        List<SelectOption> options = new List<SelectOption>();
        List<String> objList = new List<String>();
        objList.addAll(rightvalues);
        objList.sort();
        for(String s : objList){
            options.add(new SelectOption(s,s));
            tableHeaders.add(s);
        }
        return options;
    }
    
    public class EachRow{
        public List<String> rowValue;
    }
    
    public class targetTable{
        public List <EachRow> ListOfEachRow{get;set;}
        public List <string> records{get;set;}
    }
    
    public string[] removeComma(string csvData, integer headerSize){
        String csvLine = csvData;
        String prevLine = csvLine;
        Integer startIndex;
        Integer endIndex;
        
        while(csvLine.indexOf('"') > -1){
    
            if(startIndex == null){
                startIndex = csvLine.indexOf('"');
                csvLine = csvLine.substring(0, startIndex) + ':quotes:' + csvLine.substring(startIndex+1, csvLine.length());
            }else{
                if(endIndex == null){
                    endIndex = csvLine.indexOf('"');
                    csvLine = csvLine.substring(0, endIndex) + ':quotes:' + csvLine.substring(endIndex+1, csvLine.length());
                }
            }
        
            if(startIndex != null && endIndex != null){
                String sub = csvLine.substring(startIndex, endIndex);
                sub = sub.replaceAll(',', ':comma:');
                csvLine = csvLine.substring(0, startIndex) + sub + csvLine.substring(endIndex, csvLine.length());
                startIndex = null;
                endIndex = null;
            }
        }
        
        string[] csvRow = new string[]{};
        for(String column : csvLine.split(',')){            
            column = column.replaceAll(':quotes:', '').replaceAll(':comma:', ',');
            csvRow.add(column);
            System.debug('column::'+column);
        }
        system.debug('csvrow size--------'+csvRow.size());
        if(headerSize > csvRow.size() ){
            integer diff = headerSize - csvRow.size();
            for(integer i=0 ; i<=diff ; i++ ){
                csvrow.add('');
            }
        }
        return csvRow;            
    }
}