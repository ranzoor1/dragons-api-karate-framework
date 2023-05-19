#Scenario 5:
#endpoint = /api/token/verify
#With a valid token you should get response HTTP Status Code 200 and response true
Feature: Token Verify Test

  Background: Setup Test URL
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify Valid Token
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response
    And assert response == "true"

  #Scenario 6:
  #Endpoint = /api/token/verify
  #Wrong username should send as parameter
  #response HTTP Status Code 400
  #and error message "Wrong Username send along with Token"
  Scenario: Negative test validate token verify with wrong username
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "WrongUser"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  #Scnetario 7:
  #Endpoint = /api/token/verify
  #with invalid taken and valid username should have
  #status code 400 and error massage "Token Expired or Invalid Toaken"
  Scenario: Nagative test vefiry Token wiht invalied token and valid username
    Given path "/api/token/verify"
    And param token = "invalid_token"
    And param username = "supervisor"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
