Feature: Actualizar algunos campos del miembro

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')
    * configure charset = null

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
      | id | nombre | gender |
      | 5  | Jenni  | Female |

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
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jenni  | Female |

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

  Scenario Outline: Verificar actualizacion de nombre miembro con nombre vacio
    * def memberId = <id>
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

    Examples:
      | id |
      | 5  |
      | 6  |

  Scenario Outline: Verificar actualizacion de nombre de miembro que sea <descrip>
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>"}
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

    Examples:
      | id | descrip    | nombre                     |
      | 5  | menor a 4  | Jef                        |
      | 6  | mayor a 25 | SofiaDeFatimaBravoBustoooo |

  Scenario Outline: Verificar actualizacion de nombre de miembro en blanco
    * def memberId = <id>
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

    Examples:
      | id |
      | 5  |
      | 6  |

  Scenario Outline: Verificar actualizacion de nombre de miembro caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>"}
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

    Examples:
      | id | nombre |
      | 5  | Jeff#  |
      | 6  | Sofia# |

  Scenario Outline: Verificar actualizacion de nombre de miembro alfanumerico
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And request { "name": "<nombre>"}
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

    Examples:
      | id | nombre |
      | 5  | Jeff1  |
      | 6  | Sofia2 |

   #GENDER

  Scenario Outline: Verificar actualizacion de genero de miembro con genero vacio
    * def memberId = <id>
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

    Examples:
      | id |
      | 5  |
      | 6  |

  Scenario Outline: Verificar actualizacion de genero de miembro con genero invalido
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
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

    Examples:
      | id | gender    |
      | 5  | Masculino |
      | 6  | Femenino  |

  Scenario Outline: Verificar actualizacion de genero de miembro con genero con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
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

    Examples:
      | id | gender  |
      | 5  | Male$   |
      | 6  | Female$ |

  Scenario Outline: Verificar actualizacion de genero de miembro con genero alfanumerico
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    * request { "gender":"<gender>" }
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

    Examples:
      | id | gender  |
      | 5  | Male1   |
      | 6  | Female2 |

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
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 4  | Alee   | Male   |

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
      | id | nombre |
      | 5  | Jeff   |
      | 6  | Sofia  |

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
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 4  | Alee   | Male   |

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
      | id | nombre |
      | 4  | Alee   |

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
      | id | nombre |
      | 4  | Alee   |

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
      | id | nombre |
      | 5  | Jenni  |

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
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jenni  | Female |

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
      | 6  | Female |

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
    Then match response.member.name == '<nombre>'
    Then match response.member.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_PATCH_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 5  | Jenni  | Female |

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