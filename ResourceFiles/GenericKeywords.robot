*** Settings ***
Documentation     Generic Keywords that can be used in any testing site
Resource          ../Configurations/ImportGenericFile/GenericFile.robot
Library           DateTime

*** Keywords ***
Get System Date
    [Documentation]    Generate System Date
    ${date}    Get Current Date    result_format=%Y-%m-%d
    Log    ${date}

# Open Desired Browser
#     [Documentation]    Open Browser supported by Robot Framework
