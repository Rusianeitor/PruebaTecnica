function fn(){
    karate.configure('connectTimeout', 5000); //Por si se cae la api no se quede esperando a conectar más de 5 segundos
    karate.configure('readTimeout', 5000); //Por si no lee la respuesta en menos de 5 segundos
    karate.configure('logPrettyResponse', true);
    karate.configure('logPrettyRequest', true);
    karate.configure('printEnabled', true);
    karate.configure('report', true);

    var baseURL = 'http://localhost:5002/api'

    var config = {
        baseURL: baseURL
    }

    return config;
}