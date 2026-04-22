*** Settings ***
Documentation    Test Case for Pet Store Swagger - Pet Section
Resource         ../../Configurations/ImportFileSource/PetStoreSwaggerFileSource.robot
Test Tags        API
Suite Setup      Create API Session    ${ALIAS}    ${BASE_URL}

*** Test Cases ***
POST: Add New Pet - Valid Body
    [Documentation]    Create new pet using valid body
    [Tags]    Smoke    Regression    Positive
    Add New Pet    ${VALID_PET_ID}    ${VALID_PET_NAME}    ${PET_STATUS_AVAILABLE}
    Validate Pet Action Successfully    ${VALID_PET_ID}    ${VALID_PET_NAME}    ${PET_STATUS_AVAILABLE}
    [Teardown]    Delete Pet    ${VALID_PET_ID}

POST: Add New Pet - Missing Parameter
    [Documentation]    Create new pet using invalid body (missing parameter)
    ...    Issue: Even if parameter is blank or not in the body, it is still Status 200
    [Tags]    Regression    Negative    Bug
    Add New Pet    ${VALID_PET_ID}    ${EMPTY}    ${PET_STATUS_AVAILABLE}    expected_status=${STATUS_400}
    ### NOTE: Add validation pet is not created -> Once issue is fixed ###
    ### Remove Teardown once issue is fixed ###
    [Teardown]    Delete Pet    ${VALID_PET_ID}

POST: uploadImage
    [Documentation]    Create new pet using invalid body (missing parameter)
    [Tags]    Regression    Positive
    [Setup]    Add New Pet    ${VALID_PET_ID}    ${VALID_PET_NAME}    ${PET_STATUS_AVAILABLE}
    Add New Photo in Existing Pet    ${VALID_PET_ID}    ${EXECDIR}\\${PET_IMAGE_FILE_PATH}\\${PET_IMAGE_NAME}
    Validate Photo is Uploaded in Existing Pet    ${PET_IMAGE_NAME}
    [Teardown]    Delete Pet    ${VALID_PET_ID}

POST: Update Pet Data - Existing ID
    [Documentation]    Update existing pet
    [Tags]    Regression    Positive
    [Setup]    Add New Pet    ${VALID_PET_ID}    ${VALID_PET_NAME}    ${PET_STATUS_AVAILABLE}
    Update Pet using Post    ${VALID_PET_ID}    ${PET_UPDATED_NAME}    ${PET_STATUS_SOLD}
    Validate Pet Action is Successful    ${VALID_PET_ID}
    Find Pet By ID and Validate    ${VALID_PET_ID}    ${PET_UPDATED_NAME}    ${PET_STATUS_SOLD}
    [Teardown]    Delete Pet    ${VALID_PET_ID}

POST: Update Pet Data - Non-Existing ID
    [Documentation]    Update non-existing pet
    ...    Issue: Error 405 and 404 issue when using POST On Session keyword
    [Tags]    Regression    Negative    Bug
    Update Pet using Post    ${NON_EXISTING_PET_ID}    ${PET_UPDATED_NAME}    ${PET_STATUS_SOLD}    expected_status=${STATUS_404}
    Validate API Error Response    ${MESSAGE_NOT_FOUND}

GET: findByStatus - Available
    [Documentation]    Get all pet that have status available
    [Tags]    Regression    Positive
    Find Pet By Status    ${PET_STATUS_AVAILABLE}
    Validate Pet Status    ${PET_STATUS_AVAILABLE}

GET: findByStatus - Pending
    [Documentation]    Get all pet that have status pending
    [Tags]    Regression    Positive
    Find Pet By Status    ${PET_STATUS_PENDING}
    Validate Pet Status    ${PET_STATUS_PENDING}

GET: findByStatus - Sold
    [Documentation]    Get all pet that have status sold
    [Tags]    Regression    Positive
    Find Pet By Status    ${PET_STATUS_SOLD}
    Validate Pet Status    ${PET_STATUS_SOLD}

GET: findByStatus - Multiple Status
    [Documentation]    Get all pet that have status available or sold
    [Tags]    Regression    Positive
    Find Pet By Status    ${PET_STATUS_SOLD}    ${PET_STATUS_AVAILABLE}
    Validate Pet Status    ${PET_STATUS_SOLD}    ${PET_STATUS_AVAILABLE}

GET: findByStatus - Non-Existing
    [Documentation]    Get all pet that uses non-existing status in parameter
    [Tags]    Regression    Negative    Bug
    ...    Issue: Non-existing status as parameter still generates response 200
    Find Pet By Status    ${PET_STATUS_NON_EXISTING}
    ### NOTE: Add validation status is non-existing -> Once issue is fixed ###

GET: petId - Existing
    [Documentation]    Get pet using existing pet ID
    [Tags]    Smoke    Regression    Positive
    [Setup]    Add New Pet    ${VALID_PET_ID}    ${VALID_PET_NAME}    ${PET_STATUS_AVAILABLE}
    Find Pet By ID    ${VALID_PET_ID}
    Validate Pet Action Successfully    ${VALID_PET_ID}    ${VALID_PET_NAME}    ${PET_STATUS_AVAILABLE}
    [Teardown]    Delete Pet    ${VALID_PET_ID}

GET: petId - Non-Existing
    [Documentation]    Get pet using non-existing pet ID
    [Tags]    Regression    Negative    Bug
    ...    Issue: Error 404 issue when using GET On Session keyword
    Find Pet By ID    ${NON_EXISTING_PET_ID}    expected_status=${STATUS_404}    use_latest=${False}
    Validate API Error Response    ${MESSAGE_PET_NOT_FOUND}

DELETE: Existing ID
    [Documentation]    Delete pet using existing pet ID
    [Tags]    Smoke    Regression    Positive
    [Setup]    Add New Pet    ${VALID_PET_ID}    ${VALID_PET_NAME}    ${PET_STATUS_AVAILABLE}
    Delete Pet    ${VALID_PET_ID}
    Validate Pet Action is Successful    ${VALID_PET_ID}

DELETE: Non-Existing ID
    [Documentation]    Get pet using non-existing pet ID
    [Tags]    Regression    Negative    Bug
    ...    Issue: Error 404 issue when using DELETE On Session keyword
    Delete Pet    ${NON_EXISTING_PET_ID}    expected_status=${STATUS_404}    use_latest=${False}
    ### NOTE: No Error Message generated ###