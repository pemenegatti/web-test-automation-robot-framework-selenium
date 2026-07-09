*** Settings ***
Resource         ../common.resource
Variables        ../locators/carrinho_locator.yaml

*** Keywords ***
Vou para pagina de checkout
    Go To    ${BASE_URL}checkout-step-one.html
    Wait Until Element Is Visible    id:first-name
