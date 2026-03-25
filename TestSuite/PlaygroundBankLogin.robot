*** Settings ***
Documentation     Test Case for QA Playground Bank Login functionality
Resource          ../Configurations/ImportKeyword/PlaygroundBankKeywords.robot
Test Tags         LoginFunctionality
Suite Setup       Open Browser With Options   ${PLAYGROUND_BANK_LOGIN}    ${BROWSER}    ${HEADLESS}
Suite Teardown    Close All Browsers
Test Setup        Go To    ${PLAYGROUND_BANK_LOGIN}

*** Test Cases ***
Should be able to login using valid credential
    [Documentation]    User should be able to login successfully using valid credentials
    [Tags]    Smoke    Regression    Positive
    Maximize Browser Window
    Input Text    //*[@id='username']    admin
    Input Text    //*[@id='password']    admin123
    Click Button    //*[@id='login-btn']
    Wait Until Keyword Succeeds    10s    2s    Location Should Be    https://www.qaplayground.com/bank/dashboard
    Page Should Contain Button    //*[@id='logout-btn']
    [Teardown]    Run Keywords    Click Button    //*[@id='logout-btn']    AND    Handle Alert    action=ACCEPT

Should not be able to login using invalid credential
    [Documentation]    User should not be able to login successfully using invalid credentials
    [Tags]    Regression    Negatve
    Maximize Browser Window
    Input Text    //*[@id='username']    admin
    Input Text    //*[@id='password']    admin1234
    Click Button    //*[@id='login-btn']
    Element Should Contain    //*[@id='login-alert']    Invalid username or password. Please try again.

Error Message should display if Username field is blank
    [Documentation]    User should be able to see error message when username is blank
    [Tags]    Regression    Negative
    Maximize Browser Window
    Input Text    //*[@id='username']    ${EMPTY}
    Input Text    //*[@id='password']    admin123
    Click Button    //*[@id='login-btn']
    Element Should Contain    //*[@id='username-error']    Username is required

Error Message should display if Password field is blank
    [Documentation]    User should be able to see error message when password is blank
    [Tags]    Regression    Negative
    Maximize Browser Window
    Input Text    //*[@id='username']    admin
    Input Text    //*[@id='password']    ${EMPTY}
    Click Button    //*[@id='login-btn']
    Element Should Contain    //*[@id='password-error']    Password is required

Error Message should display if both username and password are blank
    [Documentation]    User should be able to see error message when username and password are blank
    [Tags]    Regression    Negative
    Maximize Browser Window
    Input Text    //*[@id='username']    ${EMPTY}
    Input Text    //*[@id='password']    ${EMPTY}
    Click Button    //*[@id='login-btn']
    Element Should Contain    //*[@id='username-error']    Username is required
    Element Should Contain    //*[@id='password-error']    Password is required

Entered password should be hidden by default
    [Documentation]    Password visibility should be hidden by default
    [Tags]    Regression    Positive
    Maximize Browser Window
    Input Text    //*[@id='password']    admin123
    Element Attribute Value Should Be    //*[@id='password']    type    password

Entered username should be removed if Clear button is clicked
    [Documentation]    User should be able to clear entered username upon clicking Clear button
    [Tags]    Regression    Positive
    Maximize Browser Window
    Input Text    //*[@id='username']    admin
    Click Button    //*[@id='clear-btn']
    Element Text Should Be    //*[@id='username']    ${EMPTY}

Entered password should be removed if Clear button is clicked
    [Documentation]    User should be able to clear entered password upon clicking Clear button
    [Tags]    Regression    Positive
    Maximize Browser Window
    Input Text    //*[@id='password']    admin123
    Click Button    //*[@id='clear-btn']
    Element Text Should Be    //*[@id='password']    ${EMPTY}

Entered username and password should be removed if Clear button is clicked
    [Documentation]    User should be able to clear entered username and password upon clicking Clear button
    [Tags]    Regression    Positive
    Maximize Browser Window
    Input Text    //*[@id='username']    admin
    Input Text    //*[@id='password']    admin123
    Click Button    //*[@id='clear-btn']
    Element Text Should Be    //*[@id='username']    ${EMPTY}
    Element Text Should Be    //*[@id='password']    ${EMPTY}

Entered password should be revealed if Eye Icon button is clicked
    [Documentation]    Password should be revealed if eye icon is clicked
    [Tags]    Regression    Positive
    Maximize Browser Window
    Input Text    //*[@id='password']    admin123
    Click Button    //*[@id='toggle-password']
    Element Attribute Value Should Be    //*[@id='password']    type    text
    Element Attribute Value Should Be    //*[@id='password']    value    admin123