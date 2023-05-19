#End 2 End Account Testing.
#Create Account
# Add Address
# Add Phone
# Add Car
# Get Account
# Note: Everything in 1 Scenario.
Feature: End-to-End Account Testing.

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    #And print result
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End-to-End Account Creation Testing
    * def dataGenerator = Java.type('api.data.GenereteData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Ali Ahamd",
      "lastName": "Ranzoor",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "Software Tester",
      "dateOfBirth": "1988-02-27"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    * def id = response.id
    #Add Address
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = id
    And request
      """
      {
      "id":,
      "addressType": "25673 Narbonne Ave",
      "addressLine1": "unit# 56",
      "city": "Lomita",
      "state": "CA",
      "postalCode": "90717",
      "countryCode": "",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.addressLine1 == "unit# 56"
    #Add Account phone
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = id
    And request
      """
      {
      "id": 0,
      "phoneNumber": "424-437-7854",
      "phoneExtension": "",
      "phoneTime": "Morning",
      "phoneType": "Home"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == "424-437-7854"
    #Add Account Car
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = id
    And request
      """
      {
      "id": 0,
      "make": "TOYOTA",
      "model": "Camry",
      "year": "2023",
      "licensePlate": "9ESL2023"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.licensePlate == "9ESL2023"
    # Get Account 
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = id
    When method get
    Then status 200
    And print response
