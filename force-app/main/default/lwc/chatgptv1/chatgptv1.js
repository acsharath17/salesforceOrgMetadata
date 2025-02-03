import { LightningElement, track } from 'lwc';
import getOpenAIResponse from '@salesforce/apex/IntegrateChatGPTWithSalesforce.getOpenAIResponse';
export default class ChatGPTv1 extends LightningElement {

  @track question = 'Hello!';
  @track IsSpinner = false;
  @track lstData = [];
  data;

// this method will be used to store the Input Value in the Variable

  handleChange(event) {
    this.question = event.target.value;
    console.log(this.question);
  }

//This method is used to call the Apex to send the request to the Open-AI

  handleClick() {
    // to start the spinner
    this.IsSpinner = true;
    getOpenAIResponse({ messageBody: this.question })
    .then(result => {
      if (result != null) {
        //update the data to the apex response
        this.data = result;
        //to stop the spinner
        this.IsSpinner = false;
      }
    });
  }
}