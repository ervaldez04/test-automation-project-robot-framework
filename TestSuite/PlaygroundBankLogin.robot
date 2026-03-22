*** Settings ***
Documentation     Test Case for QA Playground Bank Login functionality
Resource          ../Configurations/ImportKeyword/PlaygroundBankKeywords.robot
# Suite Setup       Open Browser   ${PLAYGROUND_BANK_LOGIN}    ${BROWSER_CHROME}    headless=${HEADLESS}
# Suite Setup       Open Browser   ${PLAYGROUND_BANK_LOGIN}    ${BROWSER_CHROME}
Suite Setup       Open Browser With Options   ${PLAYGROUND_BANK_LOGIN}    ${BROWSER}    ${HEADLESS}
Suite Teardown    Close All Browsers

*** Test Cases ***
Should be able to login using valid credential
    [Documentation]    User should be able to login successfully using valid credentials
    Maximize Browser Window
