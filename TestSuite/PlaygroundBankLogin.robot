*** Settings ***
Resource    ../Configurations/ImportKeyword/PlaygroundBankKeywords.robot
Documentation    Test Case for QA Playground Bank Login functionality
Suite Setup    Open Browser   ${PLAYGROUND_BANK_LOGIN}    ${BROWSER_CHROME}    headless=${HEADLESS}
Suite Teardown    Close All Browsers

*** Test Cases ***
Should be able to login using valid credential
    Maximize Browser Window
