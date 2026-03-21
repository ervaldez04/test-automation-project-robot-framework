*** Settings ***
Documentation     Generic Keywords that can be used in any testing site
Resource          ../Configurations/ImportGenericFile/GenericFile.robot
Library           DateTime

*** Keywords ***
Get System Date
    [Documentation]    Generate System Date
    ${date}    Get Current Date    result_format=%Y-%m-%d
    Log    ${date}

Open Browser With Options
    [Arguments]    ${url}    ${browser}    ${headless}

    Log    ${browser}

    # ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Run Keyword If    '${headless}'=='${True}'    Call Method    ${options}    add_argument    --headless-new
    Call Method    ${options}    add_argument    --headless-new
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size\=1920,1080
    Log    ${options}

    # Run Keyword If    '${headless}'=='true'
    # ...    Call Method    ${options}    add_argument    --headless=new

    # # Call Method    ${options}    add_argument    "--headless=new"
    # Open Browser    ${url}    ${browser}    options=${options}

    # ${defaultoption}=    Set Variable    add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-gpu");add_argument("--window-size\=1920,1080")
    # Log    ${defaultoption}
    
    # ${options}    Run Keyword If    '${headless}'=='${True}'
    # ...    Set Variable    add_argument("--headless-new");${defaultoption}
    # ...    ELSE IF    '${headless}'=='${False}'    Set Variable    ${options}    ${defaultoption}
    # ...    ELSE    Fail    Incorrect variable used
    # Log    ${options}
    # ...    AND    Create WebDriver    ${WEBDRIVER_CHROME}    options=${options}
    # Run Keyword If    '${headless}'=='${True}'
    # ...    Set Variable    ${options}    add_argument("--headless=new");${options}

    Create WebDriver    ${WEBDRIVER_CHROME}    options=${options}

    Open Browser    ${url}    ${browser}    options=${options}