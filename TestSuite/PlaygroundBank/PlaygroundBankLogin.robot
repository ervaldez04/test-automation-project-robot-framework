*** Settings ***
Documentation     Test Case for QA Playground Bank Login functionality
Resource          ../../Configurations/ImportFileSource/PlaygroundBankFileSource.robot
Test Tags         LoginFunctionality
Suite Setup       Open Browser With Options   ${PLAYGROUND_BANK_LOGIN}    ${BROWSER}    ${HEADLESS}
Suite Teardown    Close All Browsers
Test Setup        Navigate to Login Page

*** Test Cases ***
Should be able to login using valid credential
    [Documentation]    User should be able to login successfully using valid credentials
    [Tags]    Smoke    Regression    Positive
    Enter Credentials and Click Login    ${VALID_USER}    ${VALID_PASSWORD}
    Validate Successful Login
    [Teardown]    Logout of site

Should not be able to login using invalid credential
    [Documentation]    User should not be able to login successfully using invalid credentials
    [Tags]    Regression    Negatve
    Enter Credentials and Click Login    ${INVALID_USER}    ${INVALID_PASSWORD}
    Validate Login Error

Error Message should display if Username field is blank
    [Documentation]    User should be able to see error message when username is blank
    [Tags]    Regression    Negative
    Enter Credentials and Click Login    ${EMPTY}    ${VALID_PASSWORD}
    Validate Username Error

Error Message should display if Password field is blank
    [Documentation]    User should be able to see error message when password is blank
    [Tags]    Regression    Negative
    Enter Credentials and Click Login    ${VALID_USER}    ${EMPTY}
    Validate Password Error

Error Message should display if both username and password are blank
    [Documentation]    User should be able to see error message when username and password are blank
    [Tags]    Regression    Negative
    Enter Credentials and Click Login    ${EMPTY}    ${EMPTY}
    Validate Username Error
    Validate Password Error

Entered password should be hidden by default
    [Documentation]    Password visibility should be hidden by default
    [Tags]    Regression    Positive
    Enter Password    ${VALID_PASSWORD}
    Validate Password Field Type    password

Entered username should be removed if Clear button is clicked
    [Documentation]    User should be able to clear entered username upon clicking Clear button
    [Tags]    Regression    Positive
    Enter Username    ${VALID_USER}
    Click Clear Button
    Validate Username Field    ${EMPTY}

Entered password should be removed if Clear button is clicked
    [Documentation]    User should be able to clear entered password upon clicking Clear button
    [Tags]    Regression    Positive
    Enter Password    ${VALID_PASSWORD}
    Click Clear Button
    Validate Password Field    ${EMPTY}

Entered username and password should be removed if Clear button is clicked
    [Documentation]    User should be able to clear entered username and password upon clicking Clear button
    [Tags]    Regression    Positive
    Enter Credentials and Click Clear    ${VALID_USER}    ${VALID_PASSWORD}
    Validate Username Field    ${EMPTY}
    Validate Password Field    ${EMPTY}

Entered password should be revealed if Eye Icon button is clicked
    [Documentation]    Password should be revealed if eye icon is clicked
    [Tags]    Regression    Positive
    Enter Password    ${VALID_PASSWORD}
    Click Eye Icon Button
    Validate Password Field Type    text
    Validate Field Type    ${PASSWORD_FIELD}    value    ${VALID_PASSWORD}