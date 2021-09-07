Feature: Creates list of users with given input array
	Creates list of users with given input array

Background:
* url baseUrl
# You may read this inlineRequest as request/response documentation o use it for quick exploratory testing
* def inlineRequest =
"""
{
  "auth": null,
  "statusCode": 200,
  "headers": {},
  "params": null,
  "body": [
    {
      "id": 10,
      "username": "theUser",
      "firstName": "John",
      "lastName": "James",
      "email": "john@email.com",
      "password": "12345",
      "phone": "12345",
      "userStatus": 1
    }
  ],
  "matchResponse": false,
  "responseMatch": {
    "id": "##number",
    "username": "##string",
    "firstName": "##string",
    "lastName": "##string",
    "email": "##string",
    "password": "##string",
    "phone": "##string",
    "userStatus": "##number"
  },
  "responseMatchesEach": {}
}
"""

@ignore @inline
Scenario: explore createUsersWithListInput inline
	You may use this test for quick API exploratorial purposes.
	* call read('createUsersWithListInput.feature@operation') inlineRequest

Scenario Outline: Test createUsersWithListInput for <status> status code
	* def req = read(<testDataFile>)
	* def result = call read('createUsersWithListInput.feature@operation') req
	* match result.responseStatus == <status>
		Examples:
		| status | testDataFile |
		| 200 | 'test-data/createUsersWithListInput_200.yml' |
		| default | 'test-data/createUsersWithListInput_default.yml' |



@ignore @operation
Scenario: createUsersWithListInput
* def req = __arg
* def authHeader = call read('classpath:karate-auth.js') req.auth
* def headers = karate.merge(req.headers || {}, authHeader || {})
Given path '/user/createWithList'
And headers headers
And request req.body
When method POST

* if (req.matchResponse === true) karate.call('createUsersWithListInput.feature@validate')

@ignore @validate
Scenario: validate createUsersWithListInput

* def expectedStatusCode = req.statusCode || responseStatus
* match responseStatus == expectedStatusCode

# match response schema in 'test-data' or any object
* def responseContains = req.matchResponse === true? req.responseMatch : responseType == 'json'? {} : ''
* match  response contains responseContains

