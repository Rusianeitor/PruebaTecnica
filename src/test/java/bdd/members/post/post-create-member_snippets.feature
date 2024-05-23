Feature: Crear miembro temporal

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')
    * configure charset = null

  @Crear
  Scenario Outline: Verificar creacion de miembro con body valido
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 201
    And def idManipular = $.id

    Examples:
      | nombre | gender |
      | Jeff   | Male   |

  @Actualizar
  Scenario Outline: Verificar creacion de miembro con body valido 2
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 201
    And def idManipular = $.id
    And def nameManipular = $.name
    And def genderManipular = $.gender

    Examples:
      | nombre | gender |
      | Jeff   | Female |