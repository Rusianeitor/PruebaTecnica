Feature: Actualizar todos los campos del miembro

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')
    * configure charset = null
    * call read("../post/post-create-member_snippets.feature@Actualizar")

  Scenario Outline: Verificar actualizacion de miembro con body valido
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name": "<nombre>","gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre | gender |
      | idManipular | Jenni  | Female |

  Scenario Outline: Verificar actualizacion de miembro con body vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | 5  |


  Scenario Outline: Verificar actualizacion de miembro enviandole id que no existe
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 404
    Then match response.msg == "Member with id "+memberId+" doesn't exist"
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id  | nombre | gender |
      | 100 | Jeff   | Male   |


  Scenario Outline: Verificar actualizacion de miembro con nombre vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name": "","gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_2
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | gender |
      | 5  | Male   |


  Scenario Outline: Verificar actualizacion de miembro con nombre no ingresado
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | gender |
      | 5  | Male   |

  Scenario Outline: Verificar actualizacion de miembro con nombre menor a 4
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_2
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jef    | Male   |

  Scenario Outline: Verificar actualizacion de miembro con nombre mayor a 25
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_2
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre                     | gender |
      | 6  | SofiaDeFatimaBravoBustoooo | Female |

  Scenario Outline: Verificar actualizacion de miembro con nombre espacio en blanco
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": " ","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_2
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | gender |
      | 5  | Male   |

  Scenario Outline: Verificar actualizacion de miembro con nombre caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_3
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jeff#  | Male   |

  Scenario Outline: Verificar actualizacion de miembro con nombre alfanumerico
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_3
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jeff1  | Male   |

   #GENDER

  Scenario Outline: Verificar actualizacion de miembro con genero vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name": "<nombre>","gender":"" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_4
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre |
      | 5  | Jeff   |


  Scenario Outline: Verificar actualizacion de miembro con genero no ingresado
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre |
      | 5  | Jeff   |

  Scenario Outline: Verificar actualizacion de miembro con genero invalido
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_4
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender    |
      | 5  | Jeff   | Masculino |

  Scenario Outline: Verificar actualizacion de miembro con genero con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_4
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jeff   | Male$  |

  Scenario Outline: Verificar actualizacion de miembro con genero alfanumerico
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PUT_4
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jeff   | Male1  |

  #HEADERS

  Scenario Outline: Verificar actualizacion de miembro sin header Accept
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    * remove header.Accept
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre | gender |
      | idManipular | Jenni  | Female |

  Scenario Outline: Verificar actualizacion de miembro sin header Authorization
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    Given headers header
    When method put
    Then status 401
    Then match response.error == constants.CODE_401_MESSAGE_PUT
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_NO_AUTORIZADO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jeff   | Male   |

  Scenario Outline: Verificar actualizacion de miembro con header Accept vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    * set header.Accept = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PUT_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre | gender |
      | idManipular | Jenni  | Female |

  Scenario Outline: Verificar actualizacion de miembro con header Accept con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    * set header.Accept = '##'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 406
    Then match response == constants.CODE_406_MESSAGE_PUT
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jenni  | Female |

  Scenario Outline: Verificar actualizacion de miembro con header Content-Type vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    * set header.Content-Type = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.error == constants.CODE_400_MESSAGE_PUT_5
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jenni  | Female |

  Scenario Outline: Verificar actualizacion de miembro con header Content-Type con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>", "gender":"<gender>" }
    * set header.Content-Type = '##'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method put
    Then status 400
    Then match response.error == constants.CODE_400_MESSAGE_PUT_5
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jenni  | Female |