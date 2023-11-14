//Created by Damiano Strano and Mario Nicolosi on 06/11/2023.

import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getFormulaFinal from '@salesforce/apex/FormulaFormatterFinal.getFormula';


export default class FormulaFormatterBox extends LightningElement {

    data;
    isTrue = true;
    formulaValue;

    handleChange(event){
        console.log('[JS] FormulaFormatterBox handleChange [START]');

        this.formulaValue = event.detail.value;
        if(this.formulaValue != null && this.formulaValue.length >= 10){
            this.isTrue = false;
        }
        else{
            this.data = '';
            this.isTrue = true;
        }
        console.log('[JS] FormulaFormatterBox handleChange [END]');
    }

    handleSave(){
        console.log('[JS] FormulaFormatterBox handleSave [START]');

        getFormulaFinal({ formula : this.formulaValue})
        .then(result => {
            //console.log('result --> '+result);
            this.data = result;
        })
        .catch(error => {
            console.log('error --> '+error.message);
            this.isTrue = true;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: error.message,
                variant: 'error'}));
        });
        console.log('[JS] FormulaFormatterBox handleSave [END]');
    }
}