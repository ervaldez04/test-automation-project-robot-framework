### Note: arrange alhabetically ###
*** Settings ***
Documentation    Keywords used in Dashboard Page of QA Playground Bank
Resource         ../../../Configurations/ImportKeyword/PlaygroundBankKeywords.robot

*** Keywords ***
Logout of site
    [Documentation]    Logout of page
    Click Button    ${LOGOUT_BUTTON}
    Handle Alert    ${ACCEPT}