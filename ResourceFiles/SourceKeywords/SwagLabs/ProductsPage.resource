### Note: arrange alhabetically ###
*** Settings ***
Documentation    Keywords used in Products Page of Swag Labs
Resource         ../../../Configurations/ImportKeyword/SwagLabsKeywords.robot

*** Keywords ***
Add Item To Cart
    [Documentation]    Add item to cart
    [Arguments]    @{items}
    FOR    ${item}    IN    @{items}
        ${item_to_add}    Convert To Lowercase    ${item}
        ${item_to_add}    Replace String    ${item_to_add}    ${SPACE}    -
        Log    ${item_to_add}
        ${locator}=    Replace String    ${ADD_TO_CART_BUTTON}    __ITEM__    ${item_to_add}
        Click Button    ${locator}
    END
    ${current_cart_count}    Get Text    ${CART_ICON}
    Set Global Variable    ${current_cart_count}

Navigate to Products Page
    [Documentation]    Navigate to Products Page
    ${current_URL}    Get Location
    Run Keyword If    '${current_URL}'=='${INVENTORY_URL}'    Log    Page already in Dashboard Page
    ...    ELSE    Go To    ${INVENTORY_URL}

Navigate to Products Page and Add Item to Cart
    [Documentation]    Navigate to Products Page then add item to cart
    [Arguments]    @{items}
    Navigate to Products Page
    Add Item To Cart    @{items}

Remove Item In Cart
    [Documentation]    Remove item in cart
    [Arguments]    @{items}
    FOR    ${item}    IN    @{items}
        ${item_to_remove}    Convert To Lowercase    ${item}
        ${item_to_remove}    Replace String    ${item_to_remove}    ${SPACE}    -
        Log    ${item_to_remove}
        ${locator}=    Replace String    ${REMOVE_BUTTON}    __ITEM__    ${item_to_remove}
        Click Button    ${locator}
    END

Select Sort Option
    [Documentation]    Select sort to use
    [Arguments]    ${selected_sort}
    Select From List By Label    ${SORT_OPTION}    ${selected_sort}
    Run Keyword If    '${selected_sort}'=='${SORT_NAME_ASCENDING}'    Validate Sort Option Selected    ${DEFAULT_SORT_OPTION}
    ...    ELSE IF    '${selected_sort}'=='${SORT_NAME_DESCENDING}'    Validate Sort Option Selected    za
    ...    ELSE IF    '${selected_sort}'=='${SORT_PRICE_ASCENDING}'    Validate Sort Option Selected    lohi
    ...    ELSE IF    '${selected_sort}'=='${SORT_PRICE_DESCENDING}'    Validate Sort Option Selected    hilo
    ...    ELSE    FAIL    Check sort used!
    
### VALIDATION ###
Validate Add To Cart Button is not displayed
    [Documentation]    Validate add to cart button is not displayed
    [Arguments]    @{items}
    ${is_list}=    Evaluate    isinstance($items, (list, tuple))
    ${items}=    Run Keyword If    '${is_list}'=='${True}'    Create List    ${items}
    FOR    ${item}    IN    @{items}
        ### If item came in as a list element, extract the clean string ###
        ${is_str}=    Evaluate    isinstance($item, str)
        ${item}=    Run Keyword If    '${is_list}'=='${True}'    Set Variable    ${item[0]}
        ### Convert Item ###
        ${item_to_validate}    Convert To Lowercase    ${item}
        ${item_to_validate}    Remove String    ${item_to_validate}    [ ] ' '
        ${item_to_validate}    Replace String    ${item_to_validate}    ${SPACE}    -
        Log    ${item_to_validate}
        ### Update locator ###
        ${locator}=    Replace String    ${ADD_TO_CART_BUTTON}    __ITEM__    ${item_to_validate}
        ### Validate ###
        Page Should Not Contain Button    ${locator}
    END

Validate Item is Added to Cart
    [Documentation]    Validate item is added to cart
    [Arguments]    @{items}
    ### Normalize Item ###
    ${is_list}=    Evaluate    isinstance($items, (list, tuple))
    ${items}=    Run Keyword If    '${is_list}'=='${True}'    Create List    ${items}
    ### Validate number of item in cart ###
    ${count}=    Get Length    @{items}
    ${debu}    Get Text    ${CART_ICON}
    Element Text Should Be    ${CART_ICON}    ${count}
    ### Validate item is added successfully
    FOR    ${item}    IN    @{items}
        ### If item came in as a list element, extract the clean string ###
        ${is_str}=    Evaluate    isinstance($item, str)
        ${item}=    Run Keyword If    '${is_list}'=='${True}'    Set Variable    ${item[0]}
        ### Convert Item ###
        ${item_to_validate}    Convert To Lowercase    ${item}
        ${item_to_validate}    Remove String    ${item_to_validate}    [ ] ' '
        ${item_to_validate}    Replace String    ${item_to_validate}    ${SPACE}    -
        Log    ${item_to_validate}
        ### Update locator ###
        ${locator}=    Replace String    ${REMOVE_BUTTON}    __ITEM__    ${item_to_validate}
        ### Validate ###
        Page Should Contain Button    ${locator}
    END

Validate Item is Removed from Cart
    [Documentation]    Validate item is removed from cart
    [Arguments]    @{items}
    ### Normalize Item ###
    ${is_list}=    Evaluate    isinstance($items, (list, tuple))
    ${items}=    Run Keyword If    '${is_list}'=='${True}'    Create List    ${items}
    ### Validate number of item in cart ###
    ${count}=    Get Length    @{items}
    ${current_cart_count}    Convert To Integer    ${current_cart_count}
    ${count}    Convert To Integer    ${count}
    ${new_count}    Evaluate    ${current_cart_count}-${count}
    Run Keyword If    '${new_count}'=='0'    Element Should Not Be Visible    ${CART_ICON}
    ...    ELSE    Element Text Should Be    ${CART_ICON}    ${new_count}
    ### Validate item is removed successfully
    FOR    ${item}    IN    @{items}
        ### If item came in as a list element, extract the clean string ###
        ${is_str}=    Evaluate    isinstance($item, str)
        ${item}=    Run Keyword If    '${is_list}'=='${True}'    Set Variable    ${item[0]}
        ### Convert Item ###
        ${item_to_validate}    Convert To Lowercase    ${item}
        ${item_to_validate}    Remove String    ${item_to_validate}    [ ] ' '
        ${item_to_validate}    Replace String    ${item_to_validate}    ${SPACE}    -
        Log    ${item_to_validate}
        ### Update locator ###
        ${locator}=    Replace String    ${ADD_TO_CART_BUTTON}    __ITEM__    ${item_to_validate}
        ### Validate ###
        Page Should Contain Button    ${locator}
    END

Validate Sort Option
    [Documentation]    Validate sort option
    ...    ${type} is either Price or Name
    ...    ${order} is either asc or desc
    [Arguments]    ${locator}    ${type}    ${order}
    ### Check type and order values ###
    Run Keyword If    '${type}'=='price' or '${type}'=='name'    Log    ${type} is valid type
    ...    ELSE    FAIL    ${type} is invalid type!
    Run Keyword If    '${order}'=='asc' or '${order}'=='desc'    Log    ${order} is valid order
    ...    ELSE    FAIL    ${order} is invalid order!
    ### Get each Prduct ###
    ${elements}=    Get WebElements    ${locator}
    ### Create List ###
    ${values}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${num}=    Run Keyword If    '${type}'=='price'    Convert To Number    ${text.replace('$','')}
        Run Keyword If    '${type}'=='price'    Append To List    ${values}    ${num}
        Run Keyword If    '${type}'=='name'     Append To List    ${values}    ${text}
    END
    ### Copy List ###
    ${sorted}=    Copy List    ${values}
    ### Sort List ###
    Sort List    ${sorted}
    ### Sort List in Reverse ###
    Run Keyword If    '${order}'=='desc'    Reverse List    ${sorted}
    ### Validate List ###
    Lists Should Be Equal    ${values}    ${sorted}

Validate Sort Option Selected
    [Documentation]    Validate sort option selected
    [Arguments]    ${expected_sort}
    ${sort_option}=    Get Selected List Value    ${SORT_OPTION}
    Should Be Equal As Strings    ${sort_option}    ${expected_sort}