*** Settings ***
Resource         ../common.resource
Variables        ../locators/login_locator.yaml

*** Keywords ***
Que esteja na tela de login
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${USERNAME}

Que esteja logado no site Sauce Demo
    Que esteja na tela de login
    Preencho as informacoes de login
    Login e realizado

Preencho as informacoes de login
    Input Text    ${USERNAME}    ${USERNAME_VALUE}
    Input Text    ${PASSWORD}    ${PASSWORD_VALUE}

Preencho as informacoes de login com usuario invalido
    [Arguments]    ${usuario}    ${senha}
    Input Text    ${USERNAME}    ${usuario}
    Input Text    ${PASSWORD}    ${senha}

Login e realizado
    Click Button                     ${LOGIN}
    Wait Until Element Is Visible    ${SWAG_LABS}

Tento realizar o login
    Click Button    ${LOGIN}

Erro de login e exibido
    [Arguments]    ${mensagem_esperada}
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    Element Text Should Be           ${ERROR_MESSAGE}    ${mensagem_esperada}
