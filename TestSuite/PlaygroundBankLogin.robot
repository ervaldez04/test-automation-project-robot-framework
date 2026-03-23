*** Settings ***
Documentation     Test Case for QA Playground Bank Login functionality
Resource          ../Configurations/ImportKeyword/PlaygroundBankKeywords.robot
Suite Setup       Open Browser With Options   ${PLAYGROUND_BANK_LOGIN}    ${BROWSER}    ${True}
Suite Teardown    Close All Browsers

*** Test Cases ***
Should be able to login using valid credential
    [Documentation]    User should be able to login successfully using valid credentials
    Maximize Browser Window
    Input Text    //*[@id='username']    admin
    Input Text    //*[@id='password']    admin123
    Click Button    //*[@id='login-btn']