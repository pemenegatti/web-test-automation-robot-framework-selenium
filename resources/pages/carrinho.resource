*** Settings ***
Resource         ../common.resource
Variables        ../locators/carrinho_locator.yaml

*** Keywords ***
Vou para pagina de checkout
    Wait Until Element Is Visible    ${CART_LIST}
    Click Button                     ${BTN_CHECKOUT}
