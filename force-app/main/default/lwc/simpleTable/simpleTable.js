import { LightningElement  ,wire,track} from 'lwc';
import getAllOpps from '@salesforce/apex/GetAllOpportunities.getAllOps';

export default class DatatableEx12 extends LightningElement {

    @track columns = [{
            label : 'Opportunity Name',
            fieldName : 'Name',
            type : 'text',
            sortable : true
        },
        {
            label : 'Close Date',
            fieldName : 'CloseDate',
            type : 'date',
            sortable : true
        },
        {
            label : 'Stage Name',
            fieldName : 'StageName',
            type : 'date',
            sortable : true
        }
    ];
    @track error;
    @track data;
    @wire(getAllOpps)
    wiredOpps({
        error,
        data
    }){
        if(data){
            this.data = data;
            console.log(data);
            console.log(JSON.stringify(data,null,'\t'));
        }else if(error){
            this.error = error;
        }
    }
}