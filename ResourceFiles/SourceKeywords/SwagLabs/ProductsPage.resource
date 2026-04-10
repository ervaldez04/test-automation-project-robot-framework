### Note: arrange alhabetically ###
*** Settings ***
Documentation    Keywords used in Products Page of Swag Labs
Resource         ../../../Configurations/ImportKeyword/SwagLabsKeywords.robot

*** Keywords ***
Navigate to Products Page
    [Documentation]    Navigate to Products Page
    ${current_URL}    Get Location
    Run Keyword If    '${current_URL}'=='${INVENTORY_URL}'    Log    Page already in Dashboard Page
    ...    ELSE    Go To    ${INVENTORY_URL}

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