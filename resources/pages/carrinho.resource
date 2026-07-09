*** Settings ***
Resource         ../common.resource
Variables        ../locators/carrinho_locator.yaml
Variables        ../locators/checkout_locator.yaml

*** Keywords ***
Vou para pagina de checkout
    Wait Until Page Contains Element    ${CART_LIST}
    Click Button                        ${BTN_CHECKOUT}
    Wait Until Element Is Visible       ${FIRST_NAME}
