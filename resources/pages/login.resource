*** Settings ***
Library          SeleniumLibrary
Resource         ../config.resource

*** Variables ***
${LOGIN_URL}    ${URL}
${USERNAME}              //input[@id="user-name"]
${PASSWORD}              //input[@id="password"]
${LOGIN}                 //input[@id="login-button"]
${SWAG_LABS}             //div[@class="app_logo"]

*** Keywords ***
Acessar site Sauce Demo
    Go To    ${LOGIN_URL}

Preencher login e senha
    Input Text    ${USERNAME}    standard_user
    Input Text    ${PASSWORD}    secret_sauce

Realizar login
    Click Button                     ${LOGIN}
    Wait Until Element Is Visible    ${SWAG_LABS}
    Sleep    1

