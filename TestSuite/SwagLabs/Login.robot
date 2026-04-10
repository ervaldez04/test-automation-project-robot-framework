*** Settings ***
Documentation     Test Case for Swag Labs Login functionality
Resource          ../../Configurations/ImportFileSource/SwagLabsFileSource.robot
Test Tags         LoginFunctionality
Suite Setup       Open Browser With Options   ${LOGIN_URL}    ${BROWSER}    ${HEADLESS}
Suite Teardown    Close All Browsers
Test Setup        Navigate to Login Page

*** Test Cases ***
Should be able to login using valid credential
    [Documentation]    User should be able to login successfully using valid credentials
    [Tags]    Smoke    Regression    Positive
    Enter Credentials and Click Login    ${VALID_USER}    ${VALID_PASSWORD}
    # Enter Username    ${VALID_USER}
    # Enter Password    ${VALID_PASSWORD}
    # Click Login Button
    Validate Successful Login

Should not be able to login using invalid credential
    [Documentation]    User should be able to see error message when using invalid credentials
    [Tags]    Regression    Negative
    Enter Credentials and Click Login    ${INVALID_USER}    ${INVALID_PASSWORD}
    Validate Login Error    ${LOGIN_INVALID_CREDENTIAL_ERROR_MESSAGE}

Should not be able to login using locked user
    [Documentation]    User should be able to see error message when using locked user credentials
    [Tags]    Regression    Negative
    Enter Credentials and Click Login    ${LOCKED_USER}    ${VALID_PASSWORD}
    Validate Login Error    ${LOGIN_LOCKED_USER_ERROR_MESSAGE}

Error Message should display if Username field is blank
    [Documentation]    User should be able to see error message when username is blank
    [Tags]    Regression    Negative
    Enter Credentials and Click Login    ${EMPTY}    ${VALID_PASSWORD}
    Validate Login Error    ${LOGIN_USERNAME_ERROR_MESSAGE}
    
Error Message should display if Password field is blank
    [Documentation]    User should be able to see error message when password is blank
    [Tags]    Regression    Negative
    Enter Credentials and Click Login    ${VALID_USER}    ${EMPTY}
    Validate Login Error    ${LOGIN_PASSWORD_ERROR_MESSAGE}

Error Message should display if both username and password are blank
    [Documentation]    User should be able to see error message when password is blank
    [Tags]    Regression    Negative
    Enter Credentials and Click Login    ${EMPTY}    ${EMPTY}
    Validate Login Error    ${LOGIN_USERNAME_ERROR_MESSAGE}

Entered password should be hidden by default
    [Documentation]    Password visibility should be hidden by default
    [Tags]    Regression    Positive
    Enter Password    ${VALID_PASSWORD}
    Validate Password Field Type
