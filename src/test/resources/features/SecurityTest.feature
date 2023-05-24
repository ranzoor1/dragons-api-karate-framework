@Smoke @Regression
Feature: API Test Security Section

	Background: Setup Request URL
		Given url "https://tek-insurance-api.azurewebsites.net"
		And path "/api/token"

  @Test
  Scenario: Create token with valid username and password.
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 200
    And print response

  #Scenario 1:
  #endpoint = /api/token
  #if you send wrong username you should get 400 Status code
  #And API Response errorMessage "User not found"
  Scenario: Validate Token with Invalid username
    #Given prepare request
    And request {"username": "WrongUser","password": "tek_supervisor"}
    #When Send request
    When method post
    #Then Validate response.
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  #Scenario 2
  #endpoint = /api/token
  #if you send correct username and wrong password,
  #you should see 400 Bad Request and errorMessage "Password Not Matched"
  #And "httpStatus": "BAD_REQUEST",
  Scenario: Validate Token with Valid username and Invalid Password
  	And request {"username": "supervisor","password": "wrongPassword"}
  	When method post
  	Then status 400
  	And print response
  	And assert response.errorMessage == "Password Not Matched"
  	And assert response.httpStatus == "BAD_REQUEST"
  	
  	
  	
  	
  	