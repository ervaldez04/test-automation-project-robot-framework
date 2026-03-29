### Note: arrange alhabetically ###
*** Settings ***
Documentation    Keywords used in Dashboard Page of QA Playground Bank
Resource         ../../../Configurations/ImportKeyword/PlaygroundBankKeywords.robot

*** Keywords ***
Click Add Account button
    [Documentation]    Click Add Account button
    Click Link    ${ADD_ACCOUNT_BUTTON}

Logout of site
    [Documentation]    Logout of page
    Click Button    ${LOGOUT_BUTTON}
    Handle Alert    ${ACCEPT}

Navigate to Dashboard Page
    [Documentation]    Navigate to Dashboard Page
    ${current_URL}    Get Location
    Run Keyword If    '${current_URL}'=='${PLAYGROUND_BANK_DASHBOARD}'    Log    Page already in Dashboard Page
    ...    ELSE    Go To    ${PLAYGROUND_BANK_DASHBOARD}