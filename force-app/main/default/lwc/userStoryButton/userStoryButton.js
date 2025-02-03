import { LightningElement,track  } from 'lwc';

export default class UserStoryButton extends LightningElement {
    @track isShowModal = true;

    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }
}