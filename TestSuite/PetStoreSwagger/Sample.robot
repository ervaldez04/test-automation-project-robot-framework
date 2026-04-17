*** Settings ***
Documentation    Test Case for Sample API Test
Resource         ../../Configurations/ImportFileSource/PetStoreSwaggerFileSource.robot
Test Tags        API

*** Test Cases ***
Get Pets By Status
    ${params}=    Create Dictionary    status=available
    ${response}=    GET    ${BASE_URL}/pet/findByStatus    params=${params}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.json()}