*** Settings ***
Resource         ../common.resource
Variables        ../locators/checkout_locator.yaml

*** Keywords ***
Preencho as informacoes necessarias
    Wait Until Page Contains Element    ${HEADER_SECONDARY}
    ${FIRST_NAME_FAKE}                   FakerLibrary.Name
    Input Text    ${FIRST_NAME}    ${FIRST_NAME_FAKE} 
    ${LAST_NAME_FAKE}                   FakerLibrary.Name
    Input Text    ${LAST_NAME}    ${LAST_NAME_FAKE}
    ${CODIGO_POSTAL_FAKE}         FakerLibrary.Postalcode
    Input Text    ${POSTAL_CODE}    ${CODIGO_POSTAL_FAKE}
    Sleep    1

Vou para pagina de finalizacao
    Run Keyword Until Success    Click Element                 ${BTN_CONTINUE}
    Sleep    1