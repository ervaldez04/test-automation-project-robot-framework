### Note: arrange alhabetically ###
*** Settings ***
Documentation    Keywords used in Login Page of QA Playground Bank
Resource         ../../../Configurations/ImportKeyword/PlaygroundBankKeywords.robot

*** Keywords ***
Click Clear Button
    [Documentation]    Click Clear button
    Click Button    ${CLEAR_BUTTON}

Click Eye Icon Button
    [Documentation]    Click Eye Icon button
    Click Button    ${EYE_ICON_BUTTON}

Click Login Button
    [Documentation]    Click Login button
    Click Button    ${LOGIN_BUTTON}

Enter Credentials
    [Documentation]    Enter username and password
    [Arguments]    ${username}    ${password}
    Enter Username    ${username}
    Enter Password    ${password}

Enter Credentials and Click Clear
    [Documentation]    Enter credentials then click login
    [Arguments]    ${username}    ${password}
    Enter Credentials    ${username}    ${password}
    Click Clear Button

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
    Go To    ${PLAYGROUND_BANK_LOGIN}

Navigate to Login Page and Login
    [Documentation]    Navigate to Login Page and login
    [Arguments]    ${username}    ${password}
    Go To    ${PLAYGROUND_BANK_LOGIN}
    Enter Credentials and Click Login       ${username}    ${password}

Open Browser and Login
    [Documentation]    Open specific browser and logins
    [Arguments]    ${browser}    ${is_headless}    ${username}    ${password}
    ### Check if browser is open ###
    ${is_open}=    Run Keyword And Return Status    Get Location
    Run Keyword If    '${is_open}'=='${False}'    Run Keywords
    ...    Open Browser With Options   ${PLAYGROUND_BANK_LOGIN}    ${browser}    ${is_headless}
    ...    AND    Enter Credentials and Click Login    ${username}    ${password}
    ...    ELSE    Log    Browser already open
    ### Check if in QA Playground Bank and login ###
    ${current_url}=    Get Location
    ${in_playground_bank}    Run Keyword And Return Status    Should Contain    ${current_url}    ${PLAYGROUND_BANK}
    Run Keyword If    '${in_playground_bank}'=='${True}' and '${in_playground_bank}'!='${PLAYGROUND_BANK_LOGIN}'    Log    Browser is already login in QA Playground Bank
    ...    ELSE IF    '${in_playground_bank}'=='${True}' and '${in_playground_bank}'=='${PLAYGROUND_BANK_LOGIN}'    Enter Credentials and Click Login    ${username}    ${password}
    ...    ELSE    Navigate to Login Page and Login    ${username}    ${password}
    ### Validate if login successfully ###
    ${is_successful_login}    Run Keyword And Return Status    Validate Successful Login
    Run Keyword If    '${is_successful_login}'=='${True}'    Log    Login Successfully!
    ...    ELSE    Fail    Login not successful! Check credentials
    
### Validation Keywords ###
Validate Login Error
    [Documentation]    Validate error message when user credential is invalid
    Element Should Contain    ${LOGIN_ERROR_FIELD}    ${LOGIN_ERROR_MESSAGE}

Validate Password Error
    [Documentation]    Validate error message on password field
    Element Text Should Be    ${PASSWORD_ERROR_FIELD}    ${PASSWORD_ERROR_MESSAGE}

Validate Password Field
    [Documentation]    Validate password field message
    [Arguments]    ${expected_message}
    Element Text Should Be    ${PASSWORD_FIELD}    ${expected_message}

Validate Password Field Type
    [Documentation]    Validate password field type
    [Arguments]    ${field_type_value}
    Element Attribute Value Should Be    ${PASSWORD_FIELD}    type    ${field_type_value}

Validate Successful Login
    [Documentation]    Validate login successfully
    Wait Until Keyword Succeeds    10s    2s    Location Should Be    ${PLAYGROUND_BANK_DASHBOARD}
    Page Should Contain Button    ${LOGOUT_BUTTON}

Validate Username Error
    [Documentation]    Validate error message on username field
    Element Text Should Be    ${USERNAME_ERROR_FIELD}    ${USERNAME_ERROR_MESSAGE}

Validate Username Field
    [Documentation]    Validate username field message
    [Arguments]    ${expected_message}
    Element Text Should Be    ${USERNAME_FIELD}    ${expected_message}
