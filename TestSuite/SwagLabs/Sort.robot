*** Settings ***
Documentation     Test Case for Swag Labs Login functionality
Resource          ../../Configurations/ImportFileSource/SwagLabsFileSource.robot
Test Tags         SortFunctionality
Suite Setup       Open Browser and Login    ${BROWSER}    ${HEADLESS}    ${VALID_USER}    ${VALID_PASSWORD}
Suite Teardown    Close All Browsers
Test Setup        Navigate to Products Page

*** Test Cases ***
Products should be sorted by Name in Ascending Order by default
    [Documentation]    Products is sorted by name in ascending order by default
    [Tags]    Regression    Positive
    Validate Sort Option Selected    ${DEFAULT_SORT_OPTION}

Products should be able to be sorted by Name in Ascending Order
    [Documentation]    User can sort products by name in ascending order
    [Tags]    Smoke    Regression    Positive
    Select Sort Option    ${SORT_NAME_ASCENDING}
    Validate Sort Option    ${INVENTORY_NAME}    name    asc
    
Products should be able to be sorted by Name in Descending Order
    [Documentation]    User can sort products by name in descending order
    [Tags]    Regression    Positive
    Select Sort Option    ${SORT_NAME_DESCENDING}
    Validate Sort Option    ${INVENTORY_NAME}    name    desc

Products should be able to be sorted by Price in Ascending Order
    [Documentation]    User can sort products by price in ascending order
    [Tags]    Regression    Positive
    Select Sort Option    ${SORT_PRICE_ASCENDING}
    Validate Sort Option    ${INVENTORY_PRICE}    price    asc

Products should be able to be sorted by Price in Descending Order
    [Documentation]    User can sort products by price in ascending order
    [Tags]    Regression    Positive
    Select Sort Option    ${SORT_PRICE_DESCENDING}
    Validate Sort Option    ${INVENTORY_PRICE}    price    desc