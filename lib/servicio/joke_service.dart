import 'package:http/http.dart' as http;
import 'dart:math'; // Librería para sacar números aleatorios
import '/modelo/joke_model.dart'; // Importamos el molde

class JokeService {
  final String _url = "https://api.sampleapis.com/jokes/goodJokes";

  // aqui con el future decimos que esta función va a devolver un chiste (JokeModel) en algún momento, pero no sabemos cuándo exactamente porque es una operación asíncrona (porque hace una petición a internet)
  Future<JokeModel> getRandomJoke() async {
    var uri = Uri.parse(_url); //dentro de la función convertimos el string de la URL a un objeto Uri, que es lo que necesita la función http.get para hacer la petición. Esto es necesario porque http.get no acepta un string directamente, sino un Uri.
    //uri es un objeto que representa la URL de la API a la que queremos hacer la petición. Es como una dirección que le decimos a http.get: "Oye, ve a esta dirección y tráeme los datos".

    var response = await http.get(uri);// hacemos la petición a la API usando http.get, que es una función asíncrona. Le pasamos el uri que acabamos de crear. El await hace que el código espere hasta que la respuesta llegue antes de continuar con las siguientes líneas. La respuesta se guarda en la variable response.

    if (response.statusCode == 200) {//si la respuesta tiene un status code de 200, significa que la petición fue exitosa y que los datos llegaron correctamente.
      // primero convertimos el JSON que recibimos en la respuesta a una lista de objetos JokeModel usando la función jokesFromJson, que es una función que se genera automáticamente a partir del molde JokeModel. Esta función toma el JSON como input y devuelve una lista de objetos JokeModel.
      List<JokeModel> allJokes = jokesFromJson(response.body);
      
      // aqui sacamos un número aleatorio entre 0 y el número total de chistes que tenemos en la lista (allJokes.length) usando Random().nextInt(allJokes.length). Esto nos da un índice aleatorio que podemos usar para seleccionar un chiste de la lista.
      final randomIndex = Random().nextInt(allJokes.length);
      
      // devolvemos solo ese chiste aleatorio
      return allJokes[randomIndex];
    } else {
      throw Exception("Error al obtenir els acudits: ${response.statusCode}");// y sino pues lanzamos una excepción con un mensaje de error que incluye el status code de la respuesta para saber qué salió mal.
    }
  }
}