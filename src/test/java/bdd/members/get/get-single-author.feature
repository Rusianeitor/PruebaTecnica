Feature: Obtener un solo autor

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')

  Scenario Outline: Verificar autor con id valido
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | book           |
      | 1  | Monil  | Manual Testing |
      | 2  | John   | Rest API       |

  Scenario Outline: Verificar autor con id que no existe
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * def errorMsg = "Author with id " + authorId + " doesn't exist"
    Then match response.msg == errorMsg
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_NO_EXISTE)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | 40 |
      | 41 |

  Scenario Outline: Verificar autor con id con caracteres especiales
    * def authorId = '<id>'
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * def errorMsg = "Author with id " + authorId + " doesn't exist"
    Then match response.msg == errorMsg
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_NO_EXISTE)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $$ |
      | $~ |

  Scenario Outline: Verificar autor con id con caracteres especiales y minúsculas
    * def authorId = '<id>'
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * def errorMsg = "Author with id " + authorId + " doesn't exist"
    Then match response.msg == errorMsg
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_NO_EXISTE)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $a |
      | a$ |

  Scenario Outline: Verificar autor con id con caracteres especiales y mayúsculas
    * def authorId = '<id>'
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * def errorMsg = "Author with id " + authorId + " doesn't exist"
    Then match response.msg == errorMsg
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_NO_EXISTE)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id |
      | $A |
      | A$ |

  Scenario Outline: Verificar autor sin header Accept
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    * remove header.Accept
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | book           |
      | 1  | Monil  | Manual Testing |
      | 2  | John   | Rest API       |

  Scenario Outline: Verificar autor sin header Content-Type
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    * remove header.Content-Type
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | book           |
      | 1  | Monil  | Manual Testing |
      | 2  | John   | Rest API       |

  Scenario Outline: Verificar autor sin headers
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    * remove header.Accept
    * remove header.Content-Type
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | book           |
      | 1  | Monil  | Manual Testing |
      | 2  | John   | Rest API       |

  Scenario Outline: Verificar autor con header Accept vacio
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    * set header.Accept = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | book           |
      | 1  | Monil  | Manual Testing |
      | 2  | John   | Rest API       |

  Scenario Outline: Verificar autor con header Accept con caracteres especiales
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
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

  Scenario Outline: Verificar autor con header Content-Type vacio
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    * set header.Content-Type = ''
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | book           |
      | 1  | Monil  | Manual Testing |
      | 2  | John   | Rest API       |

  Scenario Outline: Verificar autor con header Content-Type con caracteres especiales
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    * set header.Content-Type = '$$'
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    * string schema = read('classpath:'+constants.SCHEMA_GET_AUTHOR_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | id | nombre | book           |
      | 1  | Monil  | Manual Testing |
      | 2  | John   | Rest API       |

  Scenario Outline: Verificar error 429 por muchas solicitudes
    #PRIMERA SOLICITUD
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    #SEGUNDA SOLICITUD
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    Then match response.name == '<nombre>'
    Then match response.books[0].name == '<book>'
    #TERCERA SOLICITUD
    * def authorId = <id>
    * url baseURL + constants.PATH_AUTHOR + authorId
    And print constants.PATH_AUTHOR
    Given headers header
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 429
    Then match response.error == constants.CODE_429_MESSAGE

    Examples:
      | id | nombre | book           |
      | 1  | Monil  | Manual Testing |