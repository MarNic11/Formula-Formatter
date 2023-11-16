//Created by Damiano Strano and Mario Nicolosi on 06/11/2023.

public with sharing class FormulaFormatterFinal {

    @AuraEnabled
    public static String getFormula(String formula){
        System.debug('[APEX] FormulaFormatterFinal getFormula [START]');

        if(formula.contains('NOT')){
            formula = formula.replace('NOT','!');
        }
        List<Integer> integerList = FormulaFormatterFinal.AscendedSortFormula(formula);
        System.debug(integerList);
        String value = formula;
        String tab = '';
        Boolean firstTime = true;
        Integer counter = 0;

        if((formula.contains('&&') || formula.contains('||')) && !(formula.contains('AND') || formula.contains('OR'))){

            Boolean lastCharacterNot = false;

            for(Integer i = 0; i < integerList.size(); i++){

                Integer x = 0;
                Boolean isNot = true;
                tab += '    ';

                if (i <= integerList.size() - 2) {
                    x = i + 1;
                }
                else{
                    x = integerList.size()-1;
                }

                if(value.substring(integerList[i]).startsWith('&&')){
                    counter++;
                    if(firstTime){
                        formula = 'AND(';
                        if(value.substring(integerList[x]).startsWith('!')){
                            isNot = false;
                            formula += value.substringBefore('&&') +','+ value.substring(integerList[i]).substringAfter('&&');
                        }
                        if(value.substring(integerList[x]).startsWith('||')){
                            formula += value.substringBefore('&&') +',\n' + tab + 'OR(' + value.substring(integerList[i]).substringBetween('&&','||') +','+ value.substring(integerList[x]).substringAfter('||');
                            counter++;
                        }
                        if(value.substring(integerList[x]).startsWith('&&')){
                            formula += value.substringBefore('&&') +',\n' + tab + 'AND(' + value.substring(integerList[i]).substringBetween('&&','&&') +','+ value.substring(integerList[x]).substringAfter('&&');
                            counter++;
                        }
                    }
                    else{
                        formula = formula.substringBefore('&&') + '\n' + tab + 'AND(';
                        if(value.substring(integerList[x]).startsWith('!')){
                            isNot = false;
                            formula += value.substringBefore('&&') +','+ value.substring(integerList[i]).substringAfter('&&');
                        }
                        if(value.substring(integerList[x]).startsWith('||')){
                            tab += '    ';
                            formula += value.substringBefore('&&') +',\n' + tab + 'OR(' + value.substring(integerList[i]).substringBetween('&&','||') +','+ value.substring(integerList[x]).substringAfter('||');
                            counter++;
                        }
                        if(value.substring(integerList[x]).startsWith('&&')){
                            tab += '    ';
                            formula += value.substringBefore('&&') +',\n' + tab + 'AND(' + value.substring(integerList[i]).substringBetween('&&','&&') +','+ value.substring(integerList[x]).substringAfter('&&');
                            counter++;
                        }
                        if(!value.substring(integerList[x]).startsWith('&&') && !value.substring(integerList[x]).startsWith('!') && !value.substring(integerList[x]).startsWith('||')){
                            formula += value.substringBefore('&&') +','+ value.substring(integerList[i]).substringAfter('&&');
                            break;
                        }
                    }
                }
                if(value.substring(integerList[i]).startsWith('||')){
                    counter++;
                    if(firstTime){
                        formula = 'OR(';
                        if(value.substring(integerList[x]).startsWith('!')){
                            isNot = false;
                            formula += value.substringBefore('||') +','+ value.substring(integerList[i]).substringAfter('||');
                        }
                        if(value.substring(integerList[x]).startsWith('&&')){
                            formula += value.substringBefore('||') +',\n' + tab + 'AND(' + value.substring(integerList[i]).substringBetween('||','&&') +','+ value.substring(integerList[x]).substringAfter('&&');
                            counter++;
                        }
                        if(value.substring(integerList[x]).startsWith('||')){
                            formula += value.substringBefore('||') +',\n' + tab + 'OR(' + value.substring(integerList[i]).substringBetween('||','||') +','+ value.substring(integerList[x]).substringAfter('||');
                            counter++;
                        }
                    }
                    else{
                        formula = formula.substringBefore('||') + '\n' + tab + ' OR(';
                        if(value.substring(integerList[x]).startsWith('!')){
                            isNot = false;
                            formula += value.substringBefore('||') +','+ value.substring(integerList[i]).substringAfter('||');
                        }
                        if(value.substring(integerList[x]).startsWith('&&')){
                            tab += '    ';
                            formula += value.substringBefore('||') +',\n' + tab + 'AND(' + value.substring(integerList[i]).substringBetween('||','&&') +','+ value.substring(integerList[x]).substringAfter('&&');
                            counter++;
                        }
                        if(value.substring(integerList[x]).startsWith('||')){
                            tab += '    ';
                            formula += value.substringBefore('||') +',\n' + tab + 'OR(' + value.substring(integerList[i]).substringBetween('||','||') +','+ value.substring(integerList[x]).substringAfter('||');
                            counter++;
                        }
                        if(!value.substring(integerList[x]).startsWith('||') && !value.substring(integerList[x]).startsWith('!') && !value.substring(integerList[x]).startsWith('&&')){
                            formula += value.substringBefore('||') +','+ value.substring(integerList[i]).substringAfter('||');
                            break;
                        }
                    }
                }
                if(value.substring(integerList[i]).startsWith('!')){
                    if(firstTime){
                        if(value.substring(integerList[x]).startsWith('&&')){
                            if(value.substringBefore('&&').right(3).contains(')')){
                                formula = 'AND(' + '\n' + tab + 'NOT(' + value.substring(integerList[i]).substringBetween('!','&&') + '),' + value.substring(integerList[x]).substringAfter('&&');
                            }
                            else{
                                formula = 'NOT(' + '\n' + tab + 'AND(' + value.substring(integerList[i]).substringBetween('!','&&') + ',' + value.substring(integerList[x]).substringAfter('&&');
                            }
                            counter++;
                        }
                        if(value.substring(integerList[x]).startsWith('||')){
                            if(value.substringBefore('||').right(3).contains(')')){
                                formula = 'OR(' + '\n' + tab + 'NOT(' + value.substring(integerList[i]).substringBetween('!','||') + '),' + value.substring(integerList[x]).substringAfter('||');
                            }
                            else{
                                formula = 'NOT(' + '\n' + tab + 'OR(' + value.substring(integerList[i]).substringBetween('!','||') + ',' + value.substring(integerList[x]).substringAfter('||');
                            }
                            counter++;
                        }
                    }
                    else{
                        formula = formula.substringBefore('!') + '\n' + tab;
                        if(value.substring(integerList[x]).startsWith('&&')){
                            tab += '    ';
                            if(value.substringBefore('&&').right(3).contains(')')){
                                formula += 'AND(' + '\n' + tab + 'NOT(' + value.substring(integerList[i]).substringBetween('!','&&') + '),' + value.substring(integerList[x]).substringAfter('&&');
                            }
                            else{
                                formula += 'NOT(' + '\n' + tab + 'AND(' + value.substring(integerList[i]).substringBetween('!','&&') + ',' + value.substring(integerList[x]).substringAfter('&&');
                            }
                            counter++;
                        }
                        if(value.substring(integerList[x]).startsWith('||')){
                            tab += '    ';
                            if(value.substringBefore('||').right(3).contains(')')){
                                formula +=  'OR(' + '\n' + tab + 'NOT(' + value.substring(integerList[i]).substringBetween('!','||') + '),' + value.substring(integerList[x]).substringAfter('||');
                            }
                            else{
                                formula +=  'NOT(' + '\n' + tab + 'OR(' + value.substring(integerList[i]).substringBetween('!','||') + ',' + value.substring(integerList[x]).substringAfter('||');
                            }
                            counter++;
                        }
                        if(!value.substring(integerList[x]).startsWith('&&') && !value.substring(integerList[x]).startsWith('||')){
                            String notLastValue = value.substring(integerList[i]).startsWith('!(') ? value.substring(integerList[i]).substringAfter('!(') : value.substring(integerList[i]).substringAfter('!');
                            formula += 'NOT(' + notLastValue;
                            lastCharacterNot = true;
                            break;
                        }
                    }
                }

                firstTime = false;
                if(isNot){
                    counter++;
                    i++;
                    isNot = true;
                }
            }

            firstTime = true;

            for (Integer i=0; i < counter; i++){

                if(!formula.endsWith(')') && firstTime){
                    tab = tab.removeEnd('    ');
                    formula = formula +')';
                    firstTime = false;
                    continue;
                }
                else if(firstTime && formula.endsWith(')))')){
                    tab = tab.removeEnd('    ');
                    formula = formula.removeEnd(')')+ '\n'+ tab +')';
                    firstTime = false;
                    continue;
                }
                else if(lastCharacterNot && firstTime && formula.endsWith('))')){
                    tab = tab.removeEnd('    ');
                    formula = formula.removeEnd(')')+ '\n'+ tab +')';
                    firstTime = false;
                    continue;
                }
                else if(firstTime && formula.endsWith('))')){
                    counter--;
                    tab = tab.removeEnd('    ');
                    formula += '\n'+ tab +')';
                    firstTime = false;
                    continue;
                }

                tab = tab.removeEnd('    ');
                formula = formula + '\n'+ tab +')';

                if(tab.length() == 0){
                    counter--;
                }
            }

            System.debug(formula);
            System.debug('[APEX] FormulaFormatterFinal getFormula [END]');
            return formula;
        }
        else if(!(formula.contains('&&') || formula.contains('||')) && (formula.contains('AND') || formula.contains('OR'))){

            for(Integer i = 0; i < integerList.size(); i++){

                if(!firstTime){
                    tab += '    ';
                    formula = formula.removeEnd(')');
                    counter++;
                }

                if(value.substring(integerList[i]).startsWith('AND')){
                    if(firstTime){
                        formula = 'and(' + formula.substring(integerList[i]).substringAfter('AND(');
                    }
                    else{
                        formula = formula.substringBefore('AND(') + '\n' + tab+ 'and(' + formula.substring(integerList[i]).substringAfter('AND(');
                    }
                }
                if(value.substring(integerList[i]).startsWith('OR')){
                    if(firstTime){
                        formula = 'or(' + formula.substring(integerList[i]).substringAfter('OR(');
                    }
                    else{
                        formula = formula.substringBefore('OR(') + '\n' + tab+ 'or(' + formula.substring(integerList[i]).substringAfter('OR(');
                    }
                }
                if(value.substring(integerList[i]).startsWith('!')){
                    if(firstTime){
                        formula = 'NOT(' + formula.substring(integerList[i]).substringAfter('!(');
                    }
                    else{
                        formula = formula.substringBefore('!(') + '\n' + tab+ 'NOT(' + formula.substring(integerList[i]).substringAfter('!(');
                    }
                }

                firstTime = false;
            }

            if(formula.contains('or')){
                formula = formula.replace('or','OR');
            }
            if(formula.contains('and')){
                formula = formula.replace('and','AND');
            }

            for (Integer i=0; i < counter; i++){
                tab = tab.removeEnd('    ');
                formula += '\n'+tab+')';
            }

            System.debug(formula);
            System.debug('[APEX] FormulaFormatterFinal getFormula [END]');
            return formula;
        }
        else{
            System.debug('[APEX] FormulaFormatterFinal getFormula [END]');
            return 'Error';
        }
    }

    public static List<Integer> AscendedSortFormula(String formula){
        System.debug('[APEX] FormulaFormatterFinal AscendedSortFormula [START]');

        List<Integer> integerList = new List<Integer>();

        for(Integer i = 0; i < formula.length(); i++){
            if(formula.substring(i).startsWith('AND')){
                integerList.add(formula.indexOf('AND',i));
                i = i + 3;
            }
            if(formula.substring(i).startsWith('OR')){
                integerList.add(formula.indexOf('OR',i));
                i = i + 2;
            }
            if(formula.substring(i).startsWith('&&')){
                integerList.add(formula.indexOf('&&',i));
                i = i + 2;
            }
            if(formula.substring(i).startsWith('||')){
                integerList.add(formula.indexOf('||',i));
                i = i + 2;
            }
            if(formula.substring(i).startsWith('!')){
                integerList.add(formula.indexOf('!',i));
                i++;
            }
        }
        System.debug('[APEX] FormulaFormatterFinal AscendedSortFormula [END]');
        return integerList;
    }
}
