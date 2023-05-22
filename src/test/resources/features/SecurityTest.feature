@Smoke @Regression
Feature: API Test Security Section

  Background: Setup Request URL
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  @Test
  Scenario: Create token wiht valid username and password
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send reqeust
    When method post
    #Validating response
    Then status 200
    And print response

  Scenario: Validate Token with invalid username
    #prepare request
    And request {"username": "supervisorr11","password": "tek_supervisor"}
    #Send reqeust
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  Scenario: Validate Token with invalid password
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor111"}
    #Send reqeust
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
    And assert response.httpStatus == "BAD_REQUEST"
