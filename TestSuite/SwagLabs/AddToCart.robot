*** Settings ***
Documentation     Test Case for Swag Labs Add To Cart functionality
Resource          ../../Configurations/ImportFileSource/SwagLabsFileSource.robot
Test Tags         SortFunctionality
Suite Setup       Open Browser and Login    ${BROWSER}    ${HEADLESS}    ${VALID_USER}    ${VALID_PASSWORD}
Suite Teardown    Close All Browsers

*** Test Cases ***
Should be able to add item in cart
    [Documentation]    User can add item in cart
    [Tags]    Smoke    Regression    Positive
    [Setup]    Navigate to Products Page
    Add Item To Cart    @{SINGLE_ITEM}
    Validate Item is Added to Cart    @{SINGLE_ITEM}
    [Teardown]    Remove Item In Cart    @{SINGLE_ITEM}

Should be able to add multiple items in cart
    [Documentation]    User can add multiple items in cart
    [Tags]    Regression    Positive
    [Setup]    Navigate to Products Page
    Add Item To Cart    @{MULTIPLE_ITEMS}
    Validate Item is Added to Cart    @{MULTIPLE_ITEMS}
    [Teardown]    Remove Item In Cart    @{MULTIPLE_ITEMS}

Should not be able to add item already in cart
    [Documentation]    User should not be able to add item already in cart
    [Tags]    Regression    Positive
    [Setup]    Navigate to Products Page and Add Item to Cart    @{ADDED_ITEMS}
    Validate Add To Cart Button is not displayed    @{ADDED_ITEMS}
    [Teardown]    Remove Item In Cart    @{ADDED_ITEMS}