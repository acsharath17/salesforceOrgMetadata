import { LightningElement,wire } from 'lwc';
import metadataList from '@salesforce/apex/packageGeneratorController.getMetadata';

export default class PackageGenerator extends LightningElement {
    pack = 'hello pack3';
    error;
    @wire(metadataList)
    mData({error,data}){
         if(data){
             alert('Success');
             console.log(JSON.stringify(data));
         } else if(error){
            
            this.error = error;
            console.log(JSON.stringify(this.error));
            alert(JSON.stringify(this.error));

         }
    }
    
}