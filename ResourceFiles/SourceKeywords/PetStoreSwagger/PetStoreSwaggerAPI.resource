### Note: arrange alhabetically ###
*** Settings ***
Documentation    Keywords used in Login Page of QA Playground Bank
Resource         ../../../Configurations/ImportKeyword/PetStoreSwaggerKeywords.robot

*** Keywords ***
Add New Pet
    [Documentation]    Add new pet
    [Arguments]    ${pet_id}    ${pet_name}    ${pet_status}    ${alias_name}=${ALIAS}    ${expected_status}=${STATUS_200}
    ${body}=    Create Dictionary    id=${pet_id}    name=${pet_name}    status=${pet_status}
    ${response}=    POST On Session    ${alias_name}    ${PET_ENDPOINT}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    Log    Response: ${response.text}
    Set Global Variable    ${response}

Add New Photo in Existing Pet
    [Documentation]    Add new photo in existing pet
    [Arguments]    ${pet_id}    ${file_path}    ${additional_metadata}=${EMPTY}    ${alias_name}=${ALIAS}    ${expected_status}=${STATUS_200}
    ### Validate photo exists ###
    ${file_exists}    Run Keyword And Return Status    File Should Exist    ${file_path}
    Run Keyword If    '${file_exists}'=='${True}'    Log    File Exists
    ...    ELSE    Fail    File doesn't exist!
    ### Send Request ###
    ${file_obj}=    Evaluate    open(r'''${file_path}''','rb')
    ${files}=    Create Dictionary    file=${file_obj}    #@${file} tells RequestsLibrary to open the file and send its binary content
    ${data}=     Create Dictionary    additionalMetadata=${additional_metadata}
    ${response}=    POST On Session    ${alias_name}    ${PET_ENDPOINT}/${pet_id}/uploadImage    files=${files}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    Log    Response: ${response.text}
    Set Global Variable    ${response}
    ### Debug ###
    Log    Response status: ${response.status_code}
    Log    Response body: ${response.text}
    Log    Response headers: ${response.headers}
    Log    Request headers: ${response.request.headers}
    Log    Request body: ${response.request.body}

Create API Session
    [Documentation]    Create API session
    [Arguments]    ${alias_name}    ${base_url_used}
    Create Session    ${alias_name}    ${base_url_used}
    Set Global Variable    ${alias_name}

Delete Pet
    [Documentation]    Delete pet
    [Arguments]    ${pet_id}    ${alias_name}=${ALIAS}    ${expected_status}=${STATUS_200}    ${use_latest}=${True}
    ### NOTE: Remove ${use_latest} argument once issue is fixed ###
    ${response}=    Run Keyword If    '${use_latest}'=='${True}'    DELETE On Session    ${alias_name}    ${PET_ENDPOINT}/${pet_id}
    ...    ELSE    Delete Request    ${alias_name}    ${PET_ENDPOINT}/${pet_id}
    # ${response}=    DELETE On Session    ${alias_name}    ${PET_ENDPOINT}/${pet_id}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    Log    Response: ${response.text}
    Set Global Variable    ${response}

Find Pet By ID
    [Documentation]    Find pet by id
    [Arguments]    ${pet_id}    ${alias_name}=${ALIAS}    ${expected_status}=${STATUS_200}    ${use_latest}=${True}
    ### NOTE: Remove ${use_latest} argument once issue is fixed ###
    ${params}=    Create Dictionary    petId=${pet_id}
    ${response}=    Run Keyword If    '${use_latest}'=='${True}'    GET On Session    ${alias_name}    ${PET_ENDPOINT}/${pet_id}
    ...    ELSE    Get Request    ${alias_name}    ${PET_ENDPOINT}/${pet_id}
    # ${response}=    GET On Session    ${alias_name}    ${PET_ENDPOINT}/${pet_id}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    Log    Response: ${response.text}
    Set Global Variable    ${response}

Find Pet By ID and Validate
    [Documentation]    Find pet by id and validate
    [Arguments]    ${pet_id}    ${pet_name}    ${pet_status}    ${alias_name}=${ALIAS}    ${expected_status}=${STATUS_200}    ${use_latest}=${True}
    ### NOTE: Remove ${use_latest} argument once issue is fixed ###
    Find Pet By ID    ${pet_id}    ${alias_name}    ${expected_status}    ${use_latest}
    Validate Pet Action Successfully    ${pet_id}    ${pet_name}    ${pet_status}

Find Pet By Status
    [Documentation]    Find pet by status
    [Arguments]    @{pet_status}    ${alias_name}=${ALIAS}    ${expected_status}=${STATUS_200}
    ${status_param}=    Catenate    SEPARATOR=,    @{pet_status}
    ${params}=    Create Dictionary    status=${status_param}
    ${response}=    GET On Session    ${alias_name}    ${PET_ENDPOINT}/findByStatus    params=${params}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    Log    Response: ${response.text}
    Set Global Variable    ${response}

Update Pet using Post
    [Documentation]    Update pet using POST
    [Arguments]    ${pet_id}    ${pet_name}    ${pet_status}    ${alias_name}=${ALIAS}    ${expected_status}=${STATUS_200}
    ${headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    # ${headers}=    Create Dictionary    Content-Type=application/json
    ${body}=    Create Dictionary    petId =${pet_id}    name=${pet_name}    status=${pet_status}
    ${response}=    POST On Session    ${alias_name}    ${PET_ENDPOINT}/${pet_id}    headers=${headers}    data=${body}
    # ${response}=    Post Request    ${alias_name}    ${PET_ENDPOINT}/${pet_id}    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    Log    Response: ${response.text}
    Set Global Variable    ${response}

### VALIDATION ###
Validate API Error Response
    [Documentation]    Validate API error response
    [Arguments]    ${message}
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal    ${response.json()["message"]}    ${message}

Validate Pet Action Successfully
    [Documentation]    Validate existing pet
    [Arguments]    ${pet_id}    ${pet_name}    ${pet_status}
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${json["id"]}    ${pet_id}
    Should Be Equal    ${json["name"]}    ${pet_name}
    Should Be Equal    ${json["status"]}    ${pet_status}

Validate Pet Action is Successful
    [Documentation]    Validate pet is updated or deleted successfully
    [Arguments]    ${pet_id}
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${json["code"]}    ${STATUS_200}
    Should Be Equal    ${json["type"]}    unknown
    Should Be Equal    ${json["message"]}    ${pet_id}

Validate Pet Status
    [Documentation]    Validate pet status
    [Arguments]    @{pet_status}
    ${pets}=    Set Variable    ${response.json()}
    FOR    ${pet}    IN    @{pets}
        Should Contain Any    ${pet["status"]}    @{pet_status}
    END

Validate Photo is Uploaded in Existing Pet
    [Documentation]    Validate photo is uploaded in existing pet
    [Arguments]    ${pet_image}    ${additional_metadata}=${EMPTY}
    ${json}=    Set Variable    ${response.json()}
    Should Contain    ${json["message"]}    File uploaded to ./${pet_image}
    Run Keyword If    '${additional_metadata}'!='${EMPTY}'    Should Contain    
    ...    ${json["message"]}    additionalMetadata:${SPACE}${additional_metadata}