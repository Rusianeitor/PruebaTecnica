Feature: Eliminar miembro

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')
    * configure charset = null
    * call read("../post/post-create-member_snippets.feature@Crear")

  Scenario: Verificar eliminacion de miembro con id valido
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is deleted successfully"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario Outline: Verificar eliminacion de miembro con id que no existe
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 404
    Then match response.msg == "Member with id "+memberId+" doesn't exist"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id  |
      | 200 |

  Scenario Outline: Verificar eliminacion de miembro con id con caracteres especiales
    * def memberId = '<id>'
    * url baseURL + constants.PATH_MEMBERS + memberId
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 404
    Then match response.msg == "Member with id "+memberId+" doesn't exist"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $  |
      | ~  |

  Scenario Outline: Verificar eliminacion de miembro con id con caracteres especiales y minúsculas
    * def memberId = '<id>'
    * url baseURL + constants.PATH_MEMBERS + memberId
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 404
    Then match response.msg == "Member with id "+memberId+" doesn't exist"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $a |
      | a~ |

  Scenario Outline: Verificar eliminacion de miembro con id con caracteres especiales y mayúsculas
    * def memberId = '<id>'
    * url baseURL + constants.PATH_MEMBERS + memberId
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 404
    Then match response.msg == "Member with id "+memberId+" doesn't exist"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $A |
      | A~ |

  Scenario: Verificar eliminacion de miembro sin header Accept
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * remove header.Accept
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is deleted successfully"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar eliminacion de miembro sin header Content-Type
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * remove header.Content-Type
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is deleted successfully"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar eliminacion de miembro sin header Authorization
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    Given headers header
    When method delete
    Then status 401
    Then match response.error == constants.CODE_401_MESSAGE_DELETE
    * string schema = read('classpath:'+constants.SCHEMA_DELETE_MEMBERS_NO_AUTORIZADO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar eliminacion de miembro con header Accept vacio
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * set header.Accept = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is deleted successfully"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar eliminacion de miembro con header Accept con caracteres especiales
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * set header.Accept = '#$'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 406
    Then match response == constants.CODE_406_MESSAGE_DELETE
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar eliminacion de miembro con header Content-Type vacio
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * set header.Content-Type = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is deleted successfully"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar eliminacion de miembro con header Content-Type con caracteres especiales
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * set header.Content-Type = '#$'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method delete
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is deleted successfully"
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response