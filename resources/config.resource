*** Settings ***
Documentation    Arquivo responsavel pelas configurações iniciais.
Library          OperatingSystem
Resource         common.resource
Variables        config/config.yaml


*** Keywords ***
Set Execution Environment
    [Documentation]    Set the execution environment to production PROD or homologation HML

    ${execution_environment}=    Get Environment Variable    EXECUTION_ENVIRONMENT    default=${CONFIG}[DEFAULT][EXECUTION_ENVIRONMENT]
    Set Global Variable    ${EXECUTION_ENVIRONMENT}    ${execution_environment}

Set Base URL
    [Documentation]    Set the base URL for the system

    ${base_url}=    Get Environment Variable    BASE_URL    default=${CONFIG}[${EXECUTION_ENVIRONMENT}][BASE_URL]
    Set Global Variable    ${BASE_URL}    ${base_url}

Set Timeout
    [Documentation]    Set the timeout for web automation actions

    ${timeout}=    Get Environment Variable    TIMEOUT    default=${CONFIG}[${EXECUTION_ENVIRONMENT}][TIMEOUT]
    Set Global Variable    ${TIMEOUT}    ${timeout}

Set Headless
    [Documentation]    Set whether the execution is in headless mode True or not False

    ${headless}=    Get Environment Variable    HEADLESS    default=${CONFIG}[DEFAULT][HEADLESS]
    Set Global Variable    ${HEADLESS}    ${headless}

Set Browser
    [Documentation]    Set the browser for automation. Some options: firefox, chrome, headlessfirefox, headlesschrome.
    ...                For more information, see: https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser"""


    ${browser}=    Get Environment Variable    BROWSER    default=${CONFIG}[${EXECUTION_ENVIRONMENT}][BROWSER]
    IF    ${HEADLESS}
        Set Global Variable    ${BROWSER}    headless${browser}
    ELSE
        Set Global Variable    ${BROWSER}    ${browser}
    END

Setup Test Environment
    Set Execution Environment
    Set Base URL
    Set Timeout
    Set Headless
    Set Browser

Setup Web Environment
    IF    ${HEADLESS}
        Open Browser   about:blank	    ${BROWSER}    options=add_argument("--headless"); add_argument("--no-sandbox"); add_argument("--window-size=1920,1080"); add_argument("--disable-dev-shm-usage")
    ELSE
        Open Browser   about:blank	    ${BROWSER}
    END

    Set Selenium Timeout    ${TIMEOUT}
    Maximize Browser Window

Teardown Web Environment
    Capture Page Screenshot
    Close All Browsers

