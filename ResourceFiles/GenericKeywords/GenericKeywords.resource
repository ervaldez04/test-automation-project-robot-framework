### Note: arrange alhabetically ###
*** Settings ***
Documentation     Generic Keywords that can be used in any testing site
Resource          ../../Configurations/ImportGenericFile/GenericFile.robot

*** Keywords ***
Get System Date
    [Documentation]    Generate System Date
    ${date}    Get Current Date    result_format=%Y-%m-%d
    Log    ${date}

Open Browser With Options
    [Arguments]    ${url}    ${browser}    ${headless}

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Run Keyword If    '${headless}'=='${True}'    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Run Keyword If    '${headless}'=='${True}'    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size\=1920,1080
    Log    ${options}

    Create WebDriver    ${WEBDRIVER_CHROME}    options=${options}
    
    Open Browser    ${url}    ${browser}    options=${options}
    Maximize Browser Window

### VALIDATION ###
Validate Field Type
    [Documentation]    Validate field type
    [Arguments]    ${webelement}    ${field_type}    ${value}
    Element Attribute Value Should Be    ${webelement}    ${field_type}    ${value}