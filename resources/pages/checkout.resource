*** Settings ***
Resource         ../common.resource
Variables        ../locators/checkout_locator.yaml

*** Keywords ***
Preencho as informacoes necessarias
    Wait Until Element Is Visible    ${FIRST_NAME}
    ${fake_first_name}=     Fake First Name
    ${fake_last_name}=      Fake Last Name
    ${fake_postal_code}=    Fake Postal Code
    Input Text    ${FIRST_NAME}     ${fake_first_name}
    Input Text    ${LAST_NAME}      ${fake_last_name}
    Input Text    ${POSTAL_CODE}    ${fake_postal_code}

Tento continuar o checkout sem preencher os campos
    Wait Until Element Is Visible    ${FIRST_NAME}
    Click Element                    ${BTN_CONTINUE}

Erro de checkout e exibido
    [Arguments]    ${mensagem_esperada}
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    Element Text Should Be           ${ERROR_MESSAGE}    ${mensagem_esperada}

Vou para pagina de finalizacao
    Run Keyword Until Success    Click Element    ${BTN_CONTINUE}
    Wait Until Element Is Visible    id:finish
