*** Settings ***
Library    SeleniumLibrary
Library    ../libs/utils.py

*** Variables ***

*** Keywords ***
Run Keyword Until Success
    [Documentation]    Executa uma keyword com retry automático por até 10 segundos
    [Arguments]    ${KW}    @{KWARGs}
    Wait Until Keyword Succeeds    10s    1s    ${KW}    @{KWARGs}