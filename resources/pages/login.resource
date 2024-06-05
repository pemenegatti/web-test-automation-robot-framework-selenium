*** Settings ***
Resource         ../common.resource
Variables        ../locators/login_locator.yaml

*** Keywords ***
Que esteja na tela de login
    Go To    ${BASE_URL}

Que esteja logado no site Sauce Demo
    Que esteja na tela de login
    Preencho as informacoes de login
    Login e realizado

Preencho as informacoes de login
    Input Text    ${USERNAME}    standard_user
    Input Text    ${PASSWORD}    secret_sauce

Login e realizado
    Click Button                     ${LOGIN}
    Wait Until Element Is Visible    ${SWAG_LABS}
    Sleep    1

