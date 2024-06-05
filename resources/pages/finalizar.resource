*** Settings ***
Resource         ../common.resource
Variables        ../locators/finalizar_locator.yaml

*** Keywords ***
Finalizo a compra
    Wait Until Page Contains Element                      ${CART_ITEM}
    Sleep    1
    Click Button                                          ${BTN_FINISH}
    Wait Until Page Contains Element                      ${PEDIDO_CONCLUIDO}
    Wait Until Page Contains Element                      ${BTN_VOLTAR_PARA_HOME}
    Sleep    1
