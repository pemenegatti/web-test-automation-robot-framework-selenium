*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
Run Keyword Until Success
    [Arguments]    ${KW}    @{KWARGs}
    Wait Until Keyword Succeeds    10s    1s    ${KW}    @{KWARGs}