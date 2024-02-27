*** Settings ***
Library          SeleniumLibrary
Resource         ../config.resource
Resource         ../utils.resource

*** Variables ***
${ADD_TO_CART}                           //button[@id="add-to-cart-sauce-labs-backpack"]
${GO_TO_CART}                            //div[@id="shopping_cart_container"]


*** Keywords ***
Adicionar produto ao carrinho
    Click Button                   ${ADD_TO_CART}

Ir para o carrinho
    Run Keyword Until Success    Click Element                    ${GO_TO_CART}
