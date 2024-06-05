*** Settings ***
Library          SeleniumLibrary

*** Variables ***
${BROWSER}                  chrome
${URL}                      https://www.saucedemo.com/
${HEADLESS_OPTIONS}         add_argument("--headless")

*** Keywords ***
Abrir Navegador
    Open Browser    browser=${BROWSER}    options=${HEADLESS_OPTIONS}
    Maximize Browser Window

Fechar Navegador
    Capture Page Screenshot
    Close Browser

Dado ${keyword}
    Run keyword   ${keyword}

Quando ${keyword}
    Run keyword   ${keyword}

Entao ${keyword}
    Run keyword   ${keyword}

E ${keyword}
    Run keyword   ${keyword}

