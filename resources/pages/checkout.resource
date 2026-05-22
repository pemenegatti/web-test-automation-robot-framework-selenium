*** Settings ***
Resource         ../common.resource
Variables        ../locators/checkout_locator.yaml

*** Keywords ***
Preencho as informacoes necessarias
    Wait Until Element Is Visible    ${HEADER_SECONDARY}
    ${fake_first_name}=     FakerLibrary.First Name
    ${fake_last_name}=      FakerLibrary.Last Name
    ${fake_postal_code}=    FakerLibrary.Postalcode
    Input Text    ${FIRST_NAME}     ${fake_first_name}
    Input Text    ${LAST_NAME}      ${fake_last_name}
    Input Text    ${POSTAL_CODE}    ${fake_postal_code}

Vou para pagina de finalizacao
    Run Keyword Until Success    Click Element    ${BTN_CONTINUE}
    Wait Until Element Is Not Visible    ${HEADER_SECONDARY}
