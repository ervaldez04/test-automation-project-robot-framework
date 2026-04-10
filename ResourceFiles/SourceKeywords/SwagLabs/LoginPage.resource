### Note: arrange alhabetically ###
*** Settings ***
Documentation    Keywords used in Login Page of Swag Labs
Resource         ../../../Configurations/ImportKeyword/SwagLabsKeywords.robot

*** Keywords ***
Click Login Button
    [Documentation]    Click Login button
    Click Button    ${LOGIN_BUTTON}

Enter Credentials
    [Documentation]    Enter username and password
    [Arguments]    ${username}    ${password}
    Enter Username    ${username}
    Enter Password    ${password}

Enter Credentials and Click Login
    [Documentation]    Enter username and password then click login
    [Arguments]    ${username}    ${password}
    Enter Credentials    ${username}    ${password}
    Click Login Button

Enter Password
    [Documentation]    Enter password in Password field
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Enter Username
    [Documentation]    Enter username in Username field
    [Arguments]    ${username}
    Input Text    ${USERNAME_FIELD}    ${username}

Navigate to Login Page
    [Documentation]    Navigate to Login Page
    Go To    ${LOGIN_URL}

### VALIDATION ###
Validate Password Field Type
    [Documentation]    Validate password field type
    [Arguments]    ${field_type_value}=password
    Element Attribute Value Should Be    ${PASSWORD_FIELD}    type    ${field_type_value}

Validate Login Error
    [Documentation]    Validate error message
    [Arguments]    ${error_message}
    Element Should Contain    ${LOGIN_ERROR_FIELD}    ${error_message}

Validate Successful Login
    [Documentation]    Validate login successfully
    Wait Until Keyword Succeeds    10s    2s    Location Should Be    ${INVENTORY_URL}
    # Page Should Contain Element    ${LOGOUT_BUTTON}