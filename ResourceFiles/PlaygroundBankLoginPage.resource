*** Settings ***
Documentation    Keywords used in Login Page of QA Playground Bank
Resource    ../Configurations/ImportKeyword/PlaygroundBankKeywords.robot

*** Keywords ***
Navigate to Login Page
    [Documentation]    Navigate to Login Page
    [Arguments]    ${browser}
    # Open Browser    ${PLAYGROUND_BANK_LOGIN}    browser=${browser}    headless=${headless}
    Open Browser    ${PLAYGROUND_BANK_LOGIN}    browser=${browser}