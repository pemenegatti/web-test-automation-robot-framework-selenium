*** Settings ***
Documentation    Arquivo responsavel pela execução dos cenarios de teste
Resource         ../resources/common.resource
Suite Setup      Setup Test Environment
Test Setup       Setup Web Environment
Test Teardown    Teardown Web Environment


*** Test Cases ***

# ─────────────────────────────────────────────
# Cenários Positivos
# ─────────────────────────────────────────────

Cenário 01: Realizar login no site Sauce Demo
    [Documentation]    Realiza o login com credenciais válidas e valida o acesso à home
    [Tags]             regressivo    smoke    login    positivo
    Given que esteja na tela de login
    When preencho as informacoes de login
    Then login e realizado

Cenário 02: Realizar compra no site Sauce Demo
    [Documentation]    Realiza uma compra completa com produto, checkout e finalização
    [Tags]             regressivo    smoke    compra    positivo
    Given Que esteja logado no site Sauce Demo
    When adicono um produto no carrinho
    And vou para pagina do carrinho
    And vou para pagina de checkout
    And preencho as informacoes necessarias
    And vou para pagina de finalizacao
    Then finalizo a compra

# ─────────────────────────────────────────────
# Cenários Negativos — Login
# ─────────────────────────────────────────────

Cenário 03: Login com usuário inválido
    [Documentation]    Tenta login com usuário inexistente e valida mensagem de erro
    [Tags]             regressivo    login    negativo
    Given que esteja na tela de login
    When preencho as informacoes de login com usuario invalido    usuario_invalido    secret_sauce
    And tento realizar o login
    Then erro de login e exibido    Epic sadface: Username and password do not match any user in this service

Cenário 04: Login com senha inválida
    [Documentation]    Tenta login com senha incorreta e valida mensagem de erro
    [Tags]             regressivo    login    negativo
    Given que esteja na tela de login
    When preencho as informacoes de login com usuario invalido    standard_user    senha_errada
    And tento realizar o login
    Then erro de login e exibido    Epic sadface: Username and password do not match any user in this service

Cenário 05: Login com campos em branco
    [Documentation]    Tenta login sem preencher nenhum campo e valida mensagem de erro
    [Tags]             regressivo    login    negativo
    Given que esteja na tela de login
    When tento realizar o login
    Then erro de login e exibido    Epic sadface: Username is required

Cenário 06: Login com usuário preenchido e senha em branco
    [Documentation]    Tenta login sem preencher a senha e valida mensagem de erro
    [Tags]             regressivo    login    negativo
    Given que esteja na tela de login
    When preencho as informacoes de login com usuario invalido    standard_user    ${EMPTY}
    And tento realizar o login
    Then erro de login e exibido    Epic sadface: Password is required

Cenário 07: Login com usuário bloqueado
    [Documentation]    Tenta login com usuário bloqueado e valida mensagem de erro
    [Tags]             regressivo    login    negativo
    Given que esteja na tela de login
    When preencho as informacoes de login com usuario invalido    locked_out_user    secret_sauce
    And tento realizar o login
    Then erro de login e exibido    Epic sadface: Sorry, this user has been locked out.

# ─────────────────────────────────────────────
# Cenários Negativos — Checkout
# ─────────────────────────────────────────────

Cenário 08: Checkout sem preencher o primeiro nome
    [Documentation]    Tenta avançar no checkout sem preencher o primeiro nome
    [Tags]             regressivo    compra    negativo
    Given Que esteja logado no site Sauce Demo
    And adicono um produto no carrinho
    And vou para pagina do carrinho
    And vou para pagina de checkout
    When tento continuar o checkout sem preencher os campos
    Then erro de checkout e exibido    Error: First Name is required

Cenário 09: Checkout sem preencher o sobrenome
    [Documentation]    Tenta avançar no checkout sem preencher o sobrenome
    [Tags]             regressivo    compra    negativo
    Given Que esteja logado no site Sauce Demo
    And adicono um produto no carrinho
    And vou para pagina do carrinho
    And vou para pagina de checkout
    When Input Text    id:first-name    João
    And tento continuar o checkout sem preencher os campos
    Then erro de checkout e exibido    Error: Last Name is required

Cenário 10: Checkout sem preencher o CEP
    [Documentation]    Tenta avançar no checkout sem preencher o código postal
    [Tags]             regressivo    compra    negativo
    Given Que esteja logado no site Sauce Demo
    And adicono um produto no carrinho
    And vou para pagina do carrinho
    And vou para pagina de checkout
    When Input Text    id:first-name    João
    And Input Text    id:last-name     Silva
    And tento continuar o checkout sem preencher os campos
    Then erro de checkout e exibido    Error: Postal Code is required
