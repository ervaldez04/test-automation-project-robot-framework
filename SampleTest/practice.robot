*** Settings ***
Resource    ../Configurations/ImportGenericFile/GenericFile.robot
Documentation    Practice
Suite Setup    New Browser    chromium    No

*** Test Cases ***
First Test Case
    [Documentation]    Practice Test
    Log    Hello world

To Do
    New Page    ${PLAYGROUND_BANK_LOGIN}
    Close Page