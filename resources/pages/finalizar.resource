*** Settings ***
Library          SeleniumLibrary
Resource         ../config.resource

*** Variables ***
${CART_ITEM}                                    //div[@class="cart_item"]
${BTN_FINISH}                                   //button[@id="finish"]
${PEDIDO_CONCLUIDO}                             //div[@id="checkout_complete_container"]
${BTN_VOLTAR_PARA_HOME}                         //button[@id="back-to-products"]

*** Keywords ***
Finalizar pedido
    Wait Until Page Contains Element                      ${CART_ITEM}
    Sleep    1
    Click Button                                          ${BTN_FINISH}
    Wait Until Page Contains Element                      ${PEDIDO_CONCLUIDO}
    Wait Until Page Contains Element                      ${BTN_VOLTAR_PARA_HOME}
    Sleep    1
