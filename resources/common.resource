*** Settings ***
Documentation    Arquivo responsavel pelo compartilhamentos de resources
Library          SeleniumLibrary
Library          FakerLibrary
Resource         config.resource
Resource         utils.resource
Resource         ../resources/pages/login.resource
Resource         ../resources/pages/home.resource
Resource         ../resources/pages/carrinho.resource
Resource         ../resources/pages/checkout.resource
Resource         ../resources/pages/finalizar.resource
