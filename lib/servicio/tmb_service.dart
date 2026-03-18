import 'dart:convert'; // ¡Aquí está el import que echabas de menos para traducir textos!
import 'package:http/http.dart' as http;
import '../modelo/tmb_model.dart'; // Importamos nuestro molde (Asegúrate de que la ruta sea correcta según tus carpetas)

class TmbService {
  //aqui asignamos las claves de la API de TMB a variables para poder usarlas luego en la función que hace la petición. 
  //Es importante no compartir estas claves públicamente, pero para este ejercicio las dejamos aquí. 
  //En un proyecto real, lo ideal sería guardarlas en un lugar seguro y no subirlas a GitHub.
  final String _appId = 'de194171'; 
  final String _appKey = '2b21c7ac4472c8d169db4036f60a3639';

  // Aquí creamos la función que se encargará de hacer la petición a la API de TMB y devolver una lista de objetos TmbBusModel con la información de los próximos buses que llegan a una parada concreta. 
  //La función recibe como parámetro el código de la parada (stopCode) que queremos consultar.
  Future<List<TmbBusModel>> getBuses(String stopCode) async {
    // 1. Preparamos la dirección. Fíjate que le pegamos el código de la parada y las claves al final, igual que hiciste en la pestaña "Params" de Postman.
    final String url = 'https://api.tmb.cat/v1/ibus/stops/$stopCode?app_id=$_appId&app_key=$_appKey';
    final uri = Uri.parse(url);

    try {
      // 2. El mensajero llama a la puerta de TMB (Petición GET)
      final response = await http.get(uri);

      // 3. Comprobamos si nos abren y todo va bien (Código 200)
      if (response.statusCode == 200) {
        // Abrimos el paquete de texto con json.decode
        final Map<String, dynamic> jsonDecoded = json.decode(response.body);
        
        // Si miramos la cap, la lista de buses está escondida dentro de "data", y luego dentro de "ibus". Así que sacamos justo esa parte:
        final List<dynamic> busesList = jsonDecoded['data']['ibus'];

        // Convertimos esa lista cruda en una lista de nuestros "Moldes" TmbBusModel
        return busesList.map((busJson) => TmbBusModel.fromJson(busJson)).toList();
      } else {
        throw Exception('Error al contactar con TMB: ${response.statusCode}');
      }
    } catch (e) {
      // Por si nos quedamos sin internet
      throw Exception('Error de conexión: $e');
    }
  }
}