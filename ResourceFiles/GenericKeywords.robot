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
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    # Run Keyword If    '${headless}'=='true'
    # ...    Call Method    ${options}    add_argument    --headless=new

    # # Call Method    ${options}    add_argument    "--headless=new"
    # Call Method    ${options}    add_argument    --no-sandbox
    # Call Method    ${options}    add_argument    --disable-dev-shm-usage
    # Call Method    ${options}    add_argument    --disable-gpu
    # Call Method    ${options}    add_argument    --window-size=1920,1080
    # Open Browser    ${url}    ${browser}    options=${options}

    # ${options}=    Set Variable    add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--window-size=1920,1080")

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Call Method    ${options}    add_argument    --headless=new
    Call Method    ${options}    add_argument    "--no-sandbox"
    Call Method    ${options}    add_argument    "--disable-dev-shm-usage"

    Run Keyword If    '${headless}'=='${True}'
    ...    Set Variable    ${options}    add_argument("--headless=new");${options}

    Create WebDriver    ${WEBDRIVER_CHROME}    options=${options}

    Open Browser    ${url}    ${browser}    options=${options}