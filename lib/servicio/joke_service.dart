import 'package:http/http.dart' as http;
import 'dart:math'; // Librería para sacar números aleatorios
import '/modelo/joke_model.dart'; // Importamos el molde

class JokeService {
  final String _url = "https://api.sampleapis.com/jokes/goodJokes";

  // Fíjate que ahora devolvemos un ÚNICO JokeModel, no una lista
  Future<JokeModel> getRandomJoke() async {
    var uri = Uri.parse(_url);
    
    // Aquí no necesitamos pasar API Key (Headers) porque esta API es pública y libre
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      // 1. Convertimos el JSON gigante en una lista de todos los chistes
      List<JokeModel> allJokes = jokesFromJson(response.body);
      
      // 2. Escogemos un número aleatorio entre 0 y el total de chistes
      final randomIndex = Random().nextInt(allJokes.length);
      
      // 3. Devolvemos solo ese chiste aleatorio
      return allJokes[randomIndex];
    } else {
      throw Exception("Error al obtenir els acudits: ${response.statusCode}");
    }
  }
}