import { LightningElement, track, wire } from 'lwc';

import getObjects from '@salesforce/apex/permissionController.getAllObject';
import getFields from '@salesforce/apex/permissionController.getAllFields';
import getPermissionSets from '@salesforce/apex/permissionController.permissionSets';
import savePermissionSets from '@salesforce/apex/permissionController.savePermission';

export default class FieldAndObjectPermissioner extends LightningElement {
    @track objects = [];
    @track fields = [];
    @track permissions = [];
    @track objAPI = '';
    @track fldAPI = '';
    @track updateResult = '';

    @wire(getObjects)
    wiredMethod({ error, data }) {
        if (data) {
            this.dataArray = data;
            let tempArray = [];
            this.dataArray.forEach(function (element) {
                var option=
                {
                    label:element,
                    value:element
                };
                tempArray.push(option);
            });
            this.objects=tempArray;
        } else if (error) {
            this.error = error;
        }
    } 
    
    handleObjectChange(event)
    {   
        const selectedOption = event.detail.value; 
        
        this.objAPI = event.detail.value; 
                
        getFields({ objectName: selectedOption})
        .then(result => {
            this.dataArray = result;
            let tempArray = [];
            this.dataArray.forEach(function (element) {
                var option=
                {
                    label:element.Label,
                    value:element.Name
                };
                tempArray.push(option);
            });
            this.fields=tempArray;
        })
        .catch(error => {
            this.error = error;
        });

    }
    handleFieldChange(event){
        const selectedOption1 = event.detail.value;
        
        this.fldAPI = selectedOption1;
        
        getPermissionSets({fieldAPI : this.fldAPI, objectAPI : this.objAPI})
        .then(result => {
            /*this.dataArray = result;
            let tempArray = [];
            this.dataArray.forEach(function(element){
                tempArray.push(element);
            }); */              
            this.permissions = result;
        })
        .catch(error => {
            this.error = error;
        });
    }

    onPermChange(event){
        alert(JSON.stringify(event.target.dataset.permissionSetName));
    }

    savePermissionChange(event){
        alert(JSON.stringify(this.permissions[0]));
        savePermissionSets({updatedPermission : this.permissions})
        .then(result => {
            this.updateResult = result;
            alert(this.updateResult);
        })
        .catch(error => {

        });
    }

    onReadPermChange(event) {
        console.log(event.target.checked);
        let currentItem = this.permissions.find(perm=>perm.permissionSetId===event.currentTarget.dataset.id);
        currentItem.readPermission = event.target.checked;
    }
    
    onWritePermChange(event) {
        console.log(event.target.checked);
        let currentItem = this.permissions.find(perm=>perm.permissionSetId===event.currentTarget.dataset.id);
        currentItem.writePermission = event.target.checked;
    }
}