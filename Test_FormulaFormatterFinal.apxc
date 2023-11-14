//Created by Damiano Strano and Mario Nicolosi on 06/11/2023.

@IsTest
global class Test_FormulaFormatterFinal {

    @IsTest
    static void testFormulaFormatter(){

        Test.startTest();
        FormulaFormatterFinal.getFormula('ISBLANK(Social_Security_Number__c) && !(AnnualRevenue < 0) || !(AnnualRevenue > 10) && !(AnnualRevenue = 50) || ISBLANK(Social_Security_Number__c))');
        FormulaFormatterFinal.getFormula('AnnualRevenue < 0 || !(ISBLANK(Social_Security_Number__c) || (AnnualRevenue > 10))');
        FormulaFormatterFinal.getFormula('!(AnnualRevenue < 0 && !(ISBLANK(BillingCity )))');
        FormulaFormatterFinal.getFormula('AnnualRevenue < 0 && (ISBLANK(Social_Security_Number__c) && (AnnualRevenue > 10) && !(AnnualRevenue > 10) && (AnnualRevenue > 10) || !(AnnualRevenue > 10))');
        FormulaFormatterFinal.getFormula('AnnualRevenue < 0 && AnnualRevenue > 10');
        Test.stopTest();
    }

    @IsTest
    static void testFormulaFormatterTab(){

        Test.startTest();
        FormulaFormatterFinal.getFormula('NOT(AND(AnnualRevenue < 0 , NOT(ISBLANK(BillingCity ))))');
        FormulaFormatterFinal.getFormula('OR(AnnualRevenue < 0 , NOT(ISBLANK(BillingCity )))');
        FormulaFormatterFinal.getFormula('AND(AnnualRevenue < 0 , NOT(ISBLANK(BillingCity )))');
        Test.stopTest();
    }
}
