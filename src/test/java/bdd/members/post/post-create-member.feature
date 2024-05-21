Feature: Crear miembro

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')
    * configure charset = null

  Scenario Outline: Verificar creacion de miembro con body valido
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 201
    Then match response.name == '<nombre>'
    Then match response.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff   | Male   |

  Scenario: Verificar creacion de miembro con body vacio
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response


  Scenario Outline: Verificar creacion de miembro enviandole el id
    * url baseURL + constants.PATH_MEMBERS_POST
    And request { "id": <id>,"name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | gender |
      | 50 | Jeff   | Male   |
      | 51 | Sofia  | Female |


  Scenario Outline: Verificar creacion de miembro con nombre vacio
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "","gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | gender |
      | Male   |
      | Female |


  Scenario Outline: Verificar creacion de miembro con nombre no ingresado
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | gender |
      | Male   |
      | Female |

  Scenario Outline: Verificar creacion de miembro con nombre con <descrip>
    * url baseURL + constants.PATH_MEMBERS_POST
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST_2
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | descrip           | nombre                     | gender |
      | nombre menor a 4  | Jef                        | Male   |
      | nombre mayor a 25 | SofiaDeFatimaBravoBustoooo | Female |

  Scenario Outline: Verificar creacion de miembro con nombre espacio en blanco
    * url baseURL + constants.PATH_MEMBERS_POST
    And request { "name": " ","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST_2
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | gender |
      | Male   |
      | Female |

  Scenario Outline: Verificar creacion de miembro con nombre caracteres especiales
    * url baseURL + constants.PATH_MEMBERS_POST
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST_3
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff#  | Male   |
      | Sofia# | Female |

  Scenario Outline: Verificar creacion de miembro con nombre alfanumerico
    * url baseURL + constants.PATH_MEMBERS_POST
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST_3
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff1  | Male   |
      | Sofia2 | Female |

   #GENDER

  Scenario Outline: Verificar creacion de miembro con genero vacio
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre |
      | Male   |
      | Female |


  Scenario Outline: Verificar creacion de miembro con genero no ingresado
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name":"<nombre>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre |
      | Jeff   |
      | Sofia  |

  Scenario Outline: Verificar creacion de miembro con genero invalido
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name":"<nombre>", "gender":"<gender>" }
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST_4
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender    |
      | Jeff   | Masculino |
      | Sofia  | Femenino  |

  Scenario Outline: Verificar creacion de miembro con genero con caracteres especiales
    * url baseURL + constants.PATH_MEMBERS_POST
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST_4
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender  |
      | Jeff   | Male#   |
      | Sofia  | Female# |

  Scenario Outline: Verificar creacion de miembro con genero alfanumerico
    * url baseURL + constants.PATH_MEMBERS_POST
    And request { "name": "<nombre>","gender":"<gender>"}
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.msg == constants.CODE_400_MESSAGE_POST_4
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender  |
      | Jeff   | Male1   |
      | Sofia  | Female2 |

  #HEADERS

  Scenario Outline: Verificar creacion de miembro sin header Accept
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"<gender>" }
    * remove header.Accept
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 201
    Then match response.name == '<nombre>'
    Then match response.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff   | Male   |

  Scenario Outline: Verificar creacion de miembro sin header Authorization
    * url baseURL + constants.PATH_MEMBERS_POST
    Given headers header
    When method post
    And request {"name": "<nombre>","gender":"<gender>"}
    Then status 401
    Then match response.error == constants.CODE_401_MESSAGE_POST
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_NO_AUTORIZADO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff   | Male   |
      | Sofia  | Female |

  Scenario Outline: Verificar creacion de miembro con header Accept vacio
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"<gender>" }
    * set header.Accept = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 201
    Then match response.name == '<nombre>'
    Then match response.gender == '<gender>'
    * string schema = read('classpath:'+constants.SCHEMA_POST_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff   | Male   |

  Scenario Outline: Verificar creacion de miembro con header Accept con caracteres especiales
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"<gender>" }
    * set header.Accept = '$'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 406
    Then match response == constants.CODE_406_MESSAGE_POST
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff   | Male   |

  Scenario Outline: Verificar creacion de miembro con header Content-Type vacio
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"<gender>" }
    * set header.Content-Type = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.error == constants.CODE_400_MESSAGE_POST_5
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff   | Male   |

  Scenario Outline: Verificar creacion de miembro con header Content-Type con caracteres especiales
    * url baseURL + constants.PATH_MEMBERS_POST
    * request { "name": "<nombre>","gender":"<gender>" }
    * set header.Content-Type = '##'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method post
    Then status 400
    Then match response.error == constants.CODE_400_MESSAGE_POST_5
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | nombre | gender |
      | Jeff   | Male   |