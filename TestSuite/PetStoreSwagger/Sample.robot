*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

*** Variables ***
${BASE_URL}    https://petstore.swagger.io/v2

*** Test Cases ***
Get Pets By Status
    ${params}=    Create Dictionary    status=available
    ${response}=    GET    ${BASE_URL}/pet/findByStatus    params=${params}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.json()}