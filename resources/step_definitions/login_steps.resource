*** Settings ***
Resource    ../pages/login.resource

*** Variables ***

*** Keywords ***
#### DADO
Que esteja na tela de login
    Acessar site Sauce Demo

Que esteja logado no site Sauce Demo
    Acessar site Sauce Demo
    Preencher login e senha
    Realizar login

#### QUANDO
Preencho as informacoes de login
    Preencher login e senha

#### ENTAO
Login e realizado
    Realizar login