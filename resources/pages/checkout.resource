*** Settings ***
Library          SeleniumLibrary
Library          FakerLibrary 
Resource         ../config.resource
Resource         ../utils.resource


*** Variables ***
${HEADER_SECONDARY}                               //span[contains(text(),'Checkout: Your Information')]
${FIRST_NAME}                                     //input[@id="first-name"]
${LAST_NAME}                                      //input[@id="last-name"]
${POSTAL_CODE}                                    //input[@id="postal-code"]
${BTN_CONTINUE}                                   //input[@id="continue"]

*** Keywords ***
Preencher informacoes
    Wait Until Page Contains Element    ${HEADER_SECONDARY}
    ${FIRST_NAME_FAKE}                   FakerLibrary.Name
    Input Text    ${FIRST_NAME}    ${FIRST_NAME_FAKE} 
    ${LAST_NAME_FAKE}                   FakerLibrary.Name
    Input Text    ${LAST_NAME}    ${LAST_NAME_FAKE}
    ${CODIGO_POSTAL_FAKE}         FakerLibrary.Postalcode
    Input Text    ${POSTAL_CODE}    ${CODIGO_POSTAL_FAKE}
    Sleep    1

Cliar em continuar no checkout
    Run Keyword Until Success    Click Element                 ${BTN_CONTINUE}
    Sleep    1