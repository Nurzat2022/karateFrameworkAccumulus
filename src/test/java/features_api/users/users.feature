Feature: Get All Users

  Background:
    * url appUrl
    * def getAccumulusSchema = read('classpath:resources/accumulus_user_schema.json')
    Given path 'api/todos/'

  @schemaValidation #complete schema test. Schema definitions are given under resources folder as json files
  Scenario: Check Response Schema
    When method GET
    Then status 200
    #And print response
    And match  each response == getAccumulusSchema

  @sizeTest #should be less than 30
  Scenario: Check The Size Of Todos
    When method GET
    Then status 200
    * def getActualLength = response[0].todos.length
    And print "getActualLength: " , getActualLength
    And assert getActualLength <= 30


  @todoTest #check the response if Accumulus task is in the response
  Scenario: Check Accumulus task is in response
    When method GET
    Then status 200
    * def expectedResponse =
                            """
                           {
                            "todo": "Finish the Accumulus coding challenge",
                            "completed": true,
                            "userId": 2,
                            "id": 1
                           }
                            """

    And match response[0].todos contains expectedResponse

  @checkTaskCompletion #check if the Accumulus task is completed
  Scenario: Check Accumulus task is completed
    When method GET
    Then status 200
    * def getIndexOfTargetedItem = function(target, item){ return target.indexOf(item) }
    * string task = "Finish the Accumulus coding challenge"
    * def allTasks = $response[0].todos[*].todo
#    And print allTasks
    * def getIndexOfTask = getIndexOfTargetedItem(allTasks , task)
    * def taskStatus = response[0].todos[getIndexOfTask].completed
    And match taskStatus == true

  @fullResponse #checking  if the full response is as expected
  Scenario: Check full Api Response
    * def fullExpectedResponse = read('classpath:resources/expectedAccumulusResponse.json')
    When method GET
    Then status 200
    And match  response == fullExpectedResponse