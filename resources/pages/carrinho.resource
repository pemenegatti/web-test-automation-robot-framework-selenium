*** Settings ***
Library          SeleniumLibrary
Resource         ../config.resource

*** Variables ***
${CART_LIST}                                      //div[@class="cart_list"]
${BTN_CHECKOUT}                                   //button[@id="checkout"]

*** Keywords ***
Ir para o checkout
    Wait Until Page Contains Element                      ${CART_LIST}
    Sleep    1
    Click Button                                          ${BTN_CHECKOUT} 
