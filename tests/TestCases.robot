*** Settings ***
Documentation    Arquivo Responsavel pela execuções dos cenarios
Resource         ../resources/common.resource
Suite Setup      Setup Test Environment
Test Setup       Setup Web Environment
Test Teardown    Run Keywords
...              Teardown Web Environment


*** Test Cases ***
Cenário 01: Realizar login no site Sauce Demo
    [Documentation]    Esse teste realizado o login no site Sauce Demo
    [Tags]             login
    Given que esteja na tela de login
	When preencho as informacoes de login
    Then login e realizado

Cenário 02: Realizar compra no site Sauce Demo
    [Documentation]    Esse teste realizado uma compra no site Sauce Demo
    [Tags]             compra
    Given Que esteja logado no site Sauce Demo
	When adicono um produto no carrinho
    And vou para pagina do carrinho
    And vou para pagina de checkout
    And preencho as informacoes necessarias
    And vou para pagina de finalizacao
    Then finalizo a compra