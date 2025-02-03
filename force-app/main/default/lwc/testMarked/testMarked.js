import { LightningElement,track } from 'lwc';

export default class TestMarked extends LightningElement {
    @track body;

    handleBodyChange(event) {
        this.body = event.target.value;
    }
}