Feature: Actualizar algunos campos del miembro

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')
    * configure charset = null
    * call read("../post/post-create-member_snippets.feature@Actualizar")

  Scenario Outline: Verificar actualizacion de nombre de miembro con body valido
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name": "<nombre>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre | gender |
      | idManipular | Jenni  | Female |

  Scenario Outline: Verificar actualizacion de genero de miembro con body valido
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender": "<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == <nombre>
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre        | gender |
      | idManipular | nameManipular | Female |

  Scenario Outline: Verificar actualizacion de miembro con body vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | 5  |

  Scenario Outline: Verificar actualizacion de nombre miembro enviandole id que no existe
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 404
    Then match response.msg == "Member with id "+memberId+" doesn't exist"
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id  | nombre |
      | 100 | Jeff   |
      | 101 | Sofia  |

  Scenario Outline: Verificar actualizacion de genero miembro enviandole id que no existe
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 404
    Then match response.msg == "Member with id "+memberId+" doesn't exist"
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id  | gender |
      | 100 | Male   |
      | 101 | Female |

  Scenario: Verificar actualizacion de nombre miembro con nombre vacio
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name": "" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_2
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar actualizacion de nombre de miembro que sea menor a 4
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "Jef"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_2
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar actualizacion de nombre de miembro que sea mayor a 25
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "SofiaDeFatimaBravoBustoooo"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_2
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar actualizacion de nombre de miembro en blanco
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": " "}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_2
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar actualizacion de nombre de miembro caracteres especiales
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "Jeff#"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_3
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar actualizacion de nombre de miembro alfanumerico
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "Jeff1"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_3
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

   #GENDER

  Scenario: Verificar actualizacion de genero de miembro con genero vacio
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_4
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar actualizacion de genero de miembro con genero invalido
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"Masculino" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_4
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Verificar actualizacion de genero de miembro con genero con caracteres especiales
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"Male$" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_4
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response


  Scenario: Verificar actualizacion de genero de miembro con genero alfanumerico
    * def memberId = idManipular
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"Male1" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_PATCH_4
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  #HEADERS CON NOMBRE

  Scenario Outline: Verificar actualizacion de nombre de miembro sin header Accept
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>"}
    * remove header.Accept
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == <gender>
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre | gender          |
      | idManipular | Alee   | genderManipular |

  Scenario Outline: Verificar actualizacion de nombre de miembro sin header Authorization
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>" }
    Given headers header
    When method patch
    Then status 401
    Then match response.error == constants.CODE_401_MESSAGE_PATCH
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_AUTORIZADO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre |
      | idManipular | Jeff   |

  Scenario Outline: Verificar actualizacion de nombre de miembro con header Accept vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>" }
    * set header.Accept = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == <gender>
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre | gender          |
      | idManipular | Alee   | genderManipular |

  Scenario Outline: Verificar actualizacion de nombre de miembro con header Accept con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>" }
    * set header.Accept = '##'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 406
    Then match response == constants.CODE_406_MESSAGE_PATCH
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre |
      | idManipular | Alee   |

  Scenario Outline: Verificar actualizacion de nombre de miembro con header Content-Type vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>" }
    * set header.Content-Type = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.error == constants.CODE_400_MESSAGE_PATCH_5
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre |
      | idManipular | Alee   |

  Scenario Outline: Verificar actualizacion de nombre de miembro con header Content-Type con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "name":"<nombre>" }
    * set header.Content-Type = '##'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.error == constants.CODE_400_MESSAGE_PATCH_5
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre |
      | idManipular | Jenni  |

  #HEADERS CON GENERO

  Scenario Outline: Verificar actualizacion de genero de miembro sin header Accept
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
    * remove header.Accept
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == <nombre>
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre        | gender |
      | idManipular | nameManipular | Female |

  Scenario Outline: Verificar actualizacion de genero de miembro sin header Authorization
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
    Given headers header
    When method patch
    Then status 401
    Then match response.error == constants.CODE_401_MESSAGE_PATCH
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_NO_AUTORIZADO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | gender |
      | 5  | Male   |

  Scenario Outline: Verificar actualizacion de genero de miembro con header Accept vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
    * set header.Accept = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 200
    Then match response.msg == "Member with id "+memberId+" is updated successfully"
    Then match response.member.id == <id>
    Then match response.member.name == <nombre>
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id          | nombre        | gender |
      | idManipular | nameManipular | Female |

  Scenario Outline: Verificar actualizacion de genero de miembro con header Accept con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
    * set header.Accept = '##'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 406
    Then match response == constants.CODE_406_MESSAGE_PATCH
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | gender |
      | 5  | Female |

  Scenario Outline: Verificar actualizacion de genero de miembro con header Content-Type vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
    * set header.Content-Type = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.error == constants.CODE_400_MESSAGE_PATCH_5
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | gender |
      | 5  | Female |

  Scenario Outline: Verificar actualizacion de genero de miembro con header Content-Type con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
    * set header.Content-Type = '##'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method patch
    Then status 400
    Then match response.error == constants.CODE_400_MESSAGE_PATCH_5
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | gender |
      | 5  | Female |