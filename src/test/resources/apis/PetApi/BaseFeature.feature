Feature: NOmbre del la feature
Todo el texto de descripción de la feature
asdfasdf
asdfasdf

Background:
# cometario esta variable viene del karate-config.js
* url miVariableUrl

Scenario: Find Pets by Status
Given url miVariableUrl
And path 'pet', 'findByStatus'
And param status = 'availableXXX'
When method GET
Then assert responseStatus == 400
* print response

Scenario: Find Pets by Tags
Given url 'https://petstore3.swagger.io/api/v3/pet/findByTags?tags=one'
When method GET
* print response

Scenario: Add new Pet
Given path 'pet'
* def myPet = 
"""
    {
  "id": 10,
  "name": "doggie",
  "category": {
    "id": 1,
    "name": "Dogs"
  },
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
}
"""
* print myPet
Given request myPet
When method post
Then assert responseStatus == 200
* print response



Scenario Outline: Add new pet <id> <name> <category> <status>
Given path 'pet'
* def myPet = 
"""
{
  "id": '#(id)',
  "name": #(name),
  "category": {
    "id": 1,
    "name": '#(category)'
  },
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": #(status)
}
"""
* print myPet
Given request myPet
When method POST
Then assert responseStatus == 200
* print response

Examples:
| id | name  | category | status    |
| 1  | dog   | one      | available |
| 2  | cat   | two      | available |
| 3  | bird  | three    | sold      |


Scenario: formato fecha
* def dateFormat = new java.text.SimpleDateFormat('yyyy/MM/dd')
* def temp = dateFormat.format(new java.util.Date())
* print temp