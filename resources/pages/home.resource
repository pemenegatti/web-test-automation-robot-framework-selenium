*** Settings ***
Resource         ../common.resource
Variables        ../locators/home_locator.yaml

*** Keywords ***
Adicono um produto no carrinho
    [Documentation]    Adiciona o produto definido em PRODUCT_ID ao carrinho
    ${add_to_cart_btn}=    Set Variable    id:add-to-cart-${PRODUCT_ID}
    Wait Until Element Is Visible    ${add_to_cart_btn}
    Click Button                     ${add_to_cart_btn}

Vou para pagina do carrinho
    Wait Until Element Is Visible    ${GO_TO_CART}
    Click Link                       ${GO_TO_CART}
    Wait Until Page Contains Element    id:checkout
