Feature: Descargar archivo

  Background:
    #Definir headers
    * def header = read('classpath:headers/headers.json')
    #Definir constantes
    * def constants = read('classpath:constants/constants.json')
    #Definir Utils
    * def schemaUtils = Java.type('util.SchemaUtils')
    * configure charset = null

  Scenario: Descargar archivo que fue previamente cargado
    * url baseURL + constants.PATH_DOWNLOAD
    And param name = 'Yey.jpg'
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 200
    And match responseHeaders.Content-type[0] == 'image/jpeg'
    * assert responseBytes.length != 0
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

  Scenario Outline: Descargar archivo que no fue previamente cargado
    * url baseURL + constants.PATH_DOWNLOAD
    And param name = '<name>'
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * match response.msg == '<name>' + " doesn't exist"
    * string schema = read('classpath:'+constants.SCHEMA_GET_FILE_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name                    |
      | imagen_no_existente.jpg |

  Scenario Outline: Descargar archivo enviando el parametro name con caracteres especiales
    * url baseURL + constants.PATH_DOWNLOAD
    And param name = '<name>'
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * match response.msg == '<name>' + " doesn't exist"
    * string schema = read('classpath:'+constants.SCHEMA_GET_FILE_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name         |
      | imagen@#.jpg |

  Scenario Outline: Descargar archivo enviando el parametro name alfanumerico
    * url baseURL + constants.PATH_DOWNLOAD
    And param name = '<name>'
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * match response.msg == '<name>' + " doesn't exist"
    * string schema = read('classpath:'+constants.SCHEMA_GET_FILE_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name          |
      | imagen123.jpg |

  Scenario Outline: Descargar archivo enviando el parametro name con espacios
    * url baseURL + constants.PATH_DOWNLOAD
    And param name = '<name>'
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * match response.msg == '<name>' + " doesn't exist"
    * string schema = read('classpath:'+constants.SCHEMA_GET_FILE_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name                    |
      | imagen no existente.jpg |

  Scenario Outline: Descargar archivo enviando el parametro name con mayusculas y minusculas
    * url baseURL + constants.PATH_DOWNLOAD
    And param name = '<name>'
    * header Authorization = call read('classpath:authorization/basic-auth.js') { username: 'admin', password: 'admin' }
    When method get
    Then status 404
    * match response.msg == '<name>' + " doesn't exist"
    * string schema = read('classpath:'+constants.SCHEMA_GET_FILE_NO_EXITOSO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response

    Examples:
      | name                  |
      | imagenNoExistente.jpg |

  Scenario: Descargar archivo que fue previamente cargado sin enviar header Authorization
    * url baseURL + constants.PATH_DOWNLOAD
    And param name = 'Test.jpg'
    When method get
    Then status 401
    Then match response.error == constants.CODE_401_MESSAGE_GET_FILE
    * string schema = read('classpath:'+constants.SCHEMA_GET_FILE_NO_AUTORIZADO)
    * string responseToString = response
    * assert schemaUtils.isValid(responseToString, schema)
    * print 'url:', karate.prevRequest.url
    * print 'headers:', karate.prevRequest.headers
    * print 'response:', response