*** Settings ***
Resource         ../common.resource
Variables        ../locators/finalizar_locator.yaml

*** Keywords ***
Finalizo a compra
    Wait Until Element Is Visible    ${CART_ITEM}
    Click Button                     ${BTN_FINISH}
    Wait Until Element Is Visible    ${PEDIDO_CONCLUIDO}
    Wait Until Element Is Visible    ${BTN_VOLTAR_PARA_HOME}
