*** Settings ***
Resource         ../resources/config.resource
Resource         ../resources/step_definitions/login_steps.resource
Resource         ../resources/step_definitions/home_steps.resource
Resource         ../resources/step_definitions/carrinho_steps.resource
Resource         ../resources/step_definitions/checkout_steps.resource
Resource         ../resources/step_definitions/finalizar_steps.resource
Test Setup       Abrir Navegador
Test Teardown    Run Keywords
...              Fechar Navegador

*** Test Cases ***
Cenário 01: Realizar login no site Sauce Demo
    [Documentation]    Esse teste realizado o login no site Sauce Demo
    [Tags]             login
    Dado que esteja na tela de login
	Quando preencho as informacoes de login
    Entao login e realizado

Cenário 02: Realizar compra no site Sauce Demo
    [Documentation]    Esse teste realizado uma compra no site Sauce Demo
    [Tags]             compra
    Dado que esteja logado no site Sauce Demo
	Quando adicono um produto no carrinho
    E vou para pagina do carrinho
    E vou para pagina de checkout
    E preencho as informacoes necessarias
    E vou para pagina de finalizacao
    Entao finalizo a compra