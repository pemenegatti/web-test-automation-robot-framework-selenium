*** Settings ***
Documentation    Arquivo responsavel pelas configurações iniciais.
Library          OperatingSystem
Resource         common.resource
Variables        config/config.yaml


*** Keywords ***
Set Execution Environment
    [Documentation]    Define o ambiente de execução: PROD ou HML

    ${execution_environment}=    Get Environment Variable    EXECUTION_ENVIRONMENT    default=${CONFIG}[DEFAULT][EXECUTION_ENVIRONMENT]
    Set Global Variable    ${EXECUTION_ENVIRONMENT}    ${execution_environment}

Set Base URL
    [Documentation]    Define a URL base do sistema

    ${base_url}=    Get Environment Variable    BASE_URL    default=${CONFIG}[${EXECUTION_ENVIRONMENT}][BASE_URL]
    Set Global Variable    ${BASE_URL}    ${base_url}

Set Timeout
    [Documentation]    Define o timeout para ações de automação web

    ${timeout}=    Get Environment Variable    TIMEOUT    default=${CONFIG}[${EXECUTION_ENVIRONMENT}][TIMEOUT]
    Set Global Variable    ${TIMEOUT}    ${timeout}

Set Headless
    [Documentation]    Define se a execução será em modo headless (True) ou não (False)

    ${headless}=    Get Environment Variable    HEADLESS    default=${CONFIG}[DEFAULT][HEADLESS]
    Set Global Variable    ${HEADLESS}    ${headless}

Set Browser
    [Documentation]    Define o navegador para automação. Opções: firefox, chrome, edge.
    ...                Mais informações: https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser

    ${browser}=    Get Environment Variable    BROWSER    default=${CONFIG}[${EXECUTION_ENVIRONMENT}][BROWSER]
    IF    ${HEADLESS}
        Set Global Variable    ${BROWSER}    headless${browser}
    ELSE
        Set Global Variable    ${BROWSER}    ${browser}
    END

Set Credentials
    [Documentation]    Define as credenciais de acesso ao sistema

    ${username}=    Get Environment Variable    USERNAME    default=${CONFIG}[DEFAULT][USERNAME]
    ${password}=    Get Environment Variable    PASSWORD    default=${CONFIG}[DEFAULT][PASSWORD]
    Set Global Variable    ${USERNAME_VALUE}    ${username}
    Set Global Variable    ${PASSWORD_VALUE}    ${password}

Set Product
    [Documentation]    Define o produto a ser utilizado nos testes

    ${product_id}=    Get Environment Variable    PRODUCT_ID    default=${CONFIG}[DEFAULT][PRODUCT_ID]
    Set Global Variable    ${PRODUCT_ID}    ${product_id}

Setup Test Environment
    Set Execution Environment
    Set Base URL
    Set Timeout
    Set Headless
    Set Browser
    Set Credentials
    Set Product

Setup Web Environment
    IF    ${HEADLESS}
        Open Browser    about:blank    ${BROWSER}    options=add_argument("--headless"); add_argument("--no-sandbox"); add_argument("--window-size=1920,1080"); add_argument("--disable-dev-shm-usage")
    ELSE
        Open Browser    about:blank    ${BROWSER}
    END

    Set Selenium Timeout    ${TIMEOUT}
    Maximize Browser Window

Teardown Web Environment
    Capture Page Screenshot
    Close All Browsers

