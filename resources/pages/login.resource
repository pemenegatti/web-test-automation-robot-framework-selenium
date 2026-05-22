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

Login e realizado
    Click Button                     ${LOGIN}
    Wait Until Element Is Visible    ${SWAG_LABS}
