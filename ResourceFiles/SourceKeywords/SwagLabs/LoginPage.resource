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

Navigate to Login Page and Login
    [Documentation]    Navigate to Login Page and login
    [Arguments]    ${username}    ${password}
    Navigate to Login Page
    Enter Credentials and Click Login       ${username}    ${password}

Open Browser and Login
    [Documentation]    Open specific browser and logins
    [Arguments]    ${browser}    ${is_headless}    ${username}    ${password}
    ### Check if browser is open ###
    ${is_open}=    Run Keyword And Return Status    Get Location
    Run Keyword If    '${is_open}'=='${False}'    Run Keywords
    ...    Open Browser With Options   ${LOGIN_URL}    ${browser}    ${is_headless}
    ...    AND    Enter Credentials and Click Login    ${username}    ${password}
    ...    ELSE    Log    Browser already open
    ### Check if in Swag Labs and login ###
    ${current_url}=    Get Location
    ${in_swag_labs}    Run Keyword And Return Status    Should Contain    ${current_url}    ${LOGIN_URL}
    Run Keyword If    '${in_swag_labs}'=='${True}' and '${current_url}'!='${LOGIN_URL}'    Log    Browser is already login in QA Playground Bank
    ...    ELSE IF    '${in_swag_labs}'=='${True}' and '${current_url}'=='${LOGIN_URL}'    Enter Credentials and Click Login    ${username}    ${password}
    ...    ELSE    Navigate to Login Page and Login    ${username}    ${password}
    ### Validate if login successfully ###
    ${is_successful_login}    Run Keyword And Return Status    Validate Successful Login
    Run Keyword If    '${is_successful_login}'=='${True}'    Log    Login Successfully!
    ...    ELSE    Fail    Login not successful! Check credentials

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