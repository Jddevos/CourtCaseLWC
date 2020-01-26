/* eslint-disable no-console */
import { LightningElement,api,track,wire } from 'lwc';
// import { getRecord } from 'lightning/uiRecordApi';
import getHierarchy from '@salesforce/apex/Witnesses.getHierarchy';

export default class Witnesses extends LightningElement {
	@api recordId;
	@track witnessList;
	@track error;

	@wire(getHierarchy, {curCase : '$recordId'}) wireHierarchy({ error, data }) {
		console.log(error);
		console.log(data);
		if (data) {
			this.witnessList = data;
			this.error = undefined;
			console.log(JSON.stringify(data, null, '\t'));
		} else {
			this.error = error;
			this.data = undefined;
			console.log(error);
		}
	}
}