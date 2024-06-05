*** Settings ***
Resource         ../common.resource
Variables        ../locators/home_locator.yaml


*** Keywords ***
Adicono um produto no carrinho
    Click Button                   ${ADD_TO_CART}

Vou para pagina do carrinho
    Run Keyword Until Success    Click Element                    ${GO_TO_CART}
