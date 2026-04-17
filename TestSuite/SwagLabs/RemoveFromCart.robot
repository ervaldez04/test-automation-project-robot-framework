*** Settings ***
Documentation     Test Case for Swag Labs Add To Cart functionality
Resource          ../../Configurations/ImportFileSource/SwagLabsFileSource.robot
Test Tags         RemoveFromCartFunctionality
Suite Setup       Open Browser and Login    ${BROWSER}    ${HEADLESS}    ${VALID_USER}    ${VALID_PASSWORD}
Suite Teardown    Close All Browsers

*** Test Cases ***
Should be able to remove item in cart
    [Documentation]    User can remove item from cart
    [Tags]    Regression    Positive
    [Setup]    Navigate to Products Page and Add Item to Cart    @{MULTIPLE_ITEMS}
    Remove Item In Cart    @{SINGLE_ITEM}
    Validate Item is Removed from Cart    @{SINGLE_ITEM}