Feature: Crud para crear Usuario

  Background:
    * url 'https://gorest.co.in/public/v2'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'
    * def dataGenerator = Java.type('Utils.DataGenerator')
    * def payload =
        """
        {
            "gender": "male",
            "status": "active"
        }
        """
    * payload.name = dataGenerator.getUserRandom().name
    * payload.email = dataGenerator.getUserRandom().email

  Scenario: Crear un nuevo usuario exitosamente
    Given path 'users'
    * def emailUnico = 'test' + java.util.UUID.randomUUID() + '@gmail.com'
    And request {"name":"Tenali Ramakrishna","gender":"male","email":"#(emailUnico)","status":"active"}
    When method post
    Then status 201
    And match response ==
    """
    {
      id: '#number',
      name: "Tenali Ramakrishna",
      email: "#(emailUnico)",
      gender: "male",
      status: "active"
    }
    """