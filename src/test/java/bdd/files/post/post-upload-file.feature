Feature: Cargar archivo

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')
    * configure charset = null

  Scenario: Cargar archivo correctamente
    * url baseURL + constants.PATH_UPLOAD
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    And multipart file file = { read: 'classpath:imgs/Yey.jpg', filename: 'Yey.jpg', contentType: 'image/jpeg' }
    And multipart field name = 'qa'
    When method post
    Then status 201
    * match response.message == constants.CODE_201_MESSAGE_POST_FILE
    * string schema = read('classpath:'+constants.SCHEMA_POST_FILE_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Cargar archivo sin enviar header Authorization
    * url baseURL + constants.PATH_UPLOAD
    And multipart file file = { read: 'classpath:imgs/Yey.jpg', filename: 'Yey.jpg', contentType: 'image/jpeg' }
    And multipart field name = 'qa'
    When method post
    Then status 401
    * match response.error == constants.CODE_401_MESSAGE_POST_FILE
    * string schema = read('classpath:'+constants.SCHEMA_POST_FILE_NO_AUTORIZADO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario: Cargar archivo sin enviar parametro name
    * url baseURL + constants.PATH_UPLOAD
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    And multipart file file = { read: 'classpath:imgs/Yey.jpg', filename: 'Yey.jpg', contentType: 'image/jpeg' }
    When method post
    Then status 201
    * match response.message == constants.CODE_201_MESSAGE_POST_FILE
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario Outline: Cargar archivo enviando el parametro name con caracteres especiales
    * url baseURL + constants.PATH_UPLOAD
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    And multipart file file = { read: 'classpath:imgs/Yey.jpg', filename: 'Yey.jpg', contentType: 'image/jpeg' }
    And multipart field name = '<name>'
    When method post
    Then status 201
    * match response.message == constants.CODE_201_MESSAGE_POST_FILE
    * string schema = read('classpath:'+constants.SCHEMA_POST_FILE_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name  |
      | imag# |
      | imag$ |

  Scenario Outline: Cargar archivo enviando el parametro name alfanumerico
    * url baseURL + constants.PATH_UPLOAD
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    And multipart file file = { read: 'classpath:imgs/Yey.jpg', filename: 'Yey.jpg', contentType: 'image/jpeg' }
    And multipart field name = '<name>'
    When method post
    Then status 201
    * match response.message == constants.CODE_201_MESSAGE_POST_FILE
    * string schema = read('classpath:'+constants.SCHEMA_POST_FILE_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name    |
      | imag123 |
      | 123imag |

  Scenario Outline: Cargar archivo enviando el parametro name con espacios
    * url baseURL + constants.PATH_UPLOAD
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    And multipart file file = { read: 'classpath:imgs/Yey.jpg', filename: 'Yey.jpg', contentType: 'image/jpeg' }
    And multipart field name = '<name>'
    When method post
    Then status 201
    * match response.message == constants.CODE_201_MESSAGE_POST_FILE
    * string schema = read('classpath:'+constants.SCHEMA_POST_FILE_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name    |
      | ima gen |
      | im agen |

  Scenario Outline: Cargar archivo enviando el parametro name con mayusculas y minusculas
    * url baseURL + constants.PATH_UPLOAD
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    And multipart file file = { read: 'classpath:imgs/Yey.jpg', filename: 'Yey.jpg', contentType: 'image/jpeg' }
    And multipart field name = '<name>'
    When method post
    Then status 201
    * match response.message == constants.CODE_201_MESSAGE_POST_FILE
    * string schema = read('classpath:'+constants.SCHEMA_POST_FILE_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name         |
      | nombreImagen |
      | NombreImagen |

  Scenario: Cargar archivo sin enviar parametro file
    * url baseURL + constants.PATH_UPLOAD
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    And multipart field name = 'qa'
    When method post
    Then status 500
    * match response.success == false
    * match response.message == {}
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response