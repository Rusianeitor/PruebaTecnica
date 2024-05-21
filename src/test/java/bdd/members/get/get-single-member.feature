Feature: Obtener un solo miembro

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')

  Scenario Outline: Verificar miembro con id valido
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | genero |
      | 1  | Monil  | Female |
      | 2  | Ramona | Female |

  Scenario Outline: Verificar miembro con id que no existe
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * def errorMsg = "Member with id " + memberId + " doesn't exist"
    Then match response.msg == errorMsg
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_NO_EXISTE)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | 40 |
      | 41 |

  Scenario Outline: Verificar miembro con id con caracteres especiales
    * def memberId = '<id>'
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * def errorMsg = "Member with id " + memberId + " doesn't exist"
    Then match response.msg == errorMsg
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_NO_EXISTE)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $$ |
      | $~ |

  Scenario Outline: Verificar miembro con id con caracteres especiales y minúsculas
    * def memberId = '<id>'
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * def errorMsg = "Member with id " + memberId + " doesn't exist"
    Then match response.msg == errorMsg
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_NO_EXISTE)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $a |
      | a$ |

  Scenario Outline: Verificar miembro con id con caracteres especiales y mayúsculas
    * def memberId = '<id>'
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * def errorMsg = "Member with id " + memberId + " doesn't exist"
    Then match response.msg == errorMsg
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_NO_EXISTE)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $A |
      | A$ |

  Scenario Outline: Verificar miembro sin header Accept
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    * remove header.Accept
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | genero |
      | 1  | Monil  | Female |
      | 2  | Ramona | Female |

  Scenario Outline: Verificar miembro sin header Content-Type
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    * remove header.Content-Type
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | genero |
      | 1  | Monil  | Female |
      | 2  | Ramona | Female |

  Scenario Outline: Verificar miembro sin headers
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    * remove header.Accept
    * remove header.Content-Type
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | genero |
      | 1  | Monil  | Female |
      | 2  | Ramona | Female |

  Scenario Outline: Verificar miembro con header Accept vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    * set header.Accept = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | genero |
      | 1  | Monil  | Female |
      | 2  | Ramona | Female |

  Scenario Outline: Verificar miembro con header Accept con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    * set header.Accept = '$$'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 406
    Then match response == 'Not Acceptable'
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | 1  |
      | 2  |

  Scenario Outline: Verificar miembro con header Content-Type vacio
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    * set header.Content-Type = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | genero |
      | 1  | Monil  | Female |
      | 2  | Ramona | Female |

  Scenario Outline: Verificar miembro con header Content-Type con caracteres especiales
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    * set header.Content-Type = '$$'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_MEMBERS_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | genero |
      | 1  | Monil  | Female |
      | 2  | Ramona | Female |

  Scenario Outline: Verificar error 429 por muchas solicitudes
    #PRIMERA SOLICITUD
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    #SEGUNDA SOLICITUD
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.gender == '<genero>'
    #TERCERA SOLICITUD
    * def memberId = <id>
    * url baseURL + constants.PATH_MEMBERS + memberId
    And print constants.PATH_MEMBERS
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 429
    Then match response.error == constants.CODE_429_MESSAGE

    Examples:
      | id | nombre | genero |
      | 1  | Monil  | Female |