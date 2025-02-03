import { LightningElement, track, wire } from 'lwc';
import getAllApexClasses from '@salesforce/apex/metadataSummariser.getAllApexClasses';

export default class ApexClassSummariser extends LightningElement {
    @track apexClassOptions;
    @track selectedApexClass;
    @track largeText;

    @wire(getAllApexClasses)
    wiredApexClasses({data, error}) {
        if(data) {
            if(Array.isArray(data)) {
                this.apexClassOptions = data.map(apexClass => {
                    return {
                        label: apexClass.name,
                        value: apexClass.body
                    };
                });
                this.error = undefined;
            } else {
                this.error = 'Data received is not an array.';
                this.apexClassOptions = undefined;
            }
        } else if(error) {
            this.error = error;
            this.apexClassOptions = undefined;
        }
    }

    handleChange(event) {
        this.selectedApexClass = event.detail.value;

        // Update the large text based on the selected Apex class
        this.largeText = this.selectedApexClass;
    }
}