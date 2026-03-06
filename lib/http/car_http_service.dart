import 'package:http/http.dart' as http;
import '/car_model.dart'; // Asegúrate de que la ruta es correcta según dónde lo hayas guardado

class CarHttpService {
  final String _serverUrl = "https://car-data.p.rapidapi.com/cars?limit=10&page=0"; //Aquí insertamos la URL completa a la que queremos ir (la que vimos en Postman)
  final String _headerKey = "6bb8fa4471msha1a38ad4fa1c9fbp150f65jsn318b1c8c0507"; // Aquí insertamos nuestra propia API Key de la pagina de RapidAPI!
  final String _headerHost = "car-data.p.rapidapi.com";

  // Este es el método que irá a internet a por los coches
  Future<List<CarsModel>> getCars() async {
    // 1. Preparamos la dirección completa a la que vamos a ir
    var uri = Uri.parse("$_serverUrl/cars"); 

    // 2. Hacemos la petición GET (como en Postman) pasándole nuestras claves
    var response = await http.get(uri, headers: {
      "x-rapidapi-key": _headerKey, 
      "x-rapidapi-host": _headerHost
    });

    // 3. Comprobamos si el servidor nos ha respondido bien (Código 200 significa "Todo OK")
    if (response.statusCode == 200) {
      // Usamos la función que creaste antes para convertir el texto JSON a una lista de tus objetos
      return carsModelFromJson(response.body);
    } else {
      // Si algo falla, lanzamos un error
      throw ("Error al obtener la llista de cotxes: ${response.statusCode}");
    }
  }
}