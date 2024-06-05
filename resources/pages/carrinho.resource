*** Settings ***
Resource         ../common.resource
Variables        ../locators/carrinho_locator.yaml

*** Keywords ***
Vou para pagina de checkout
    Wait Until Page Contains Element                      ${CART_LIST}
    Sleep    1
    Click Button                                          ${BTN_CHECKOUT} 
