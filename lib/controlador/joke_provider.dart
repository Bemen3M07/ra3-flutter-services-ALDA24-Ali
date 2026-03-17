import 'package:flutter/material.dart';
import '/modelo/joke_model.dart';
import '/servicio/joke_service.dart';

// El "ChangeNotifier" permite que esta clase AVISE a la pantalla cuando haya cambios
class JokeProvider extends ChangeNotifier {
  JokeModel? currentJoke; // Guardamos el chiste actual (el '?' significa que al principio puede estar vacío/nulo)
  bool isLoading = false; // bool para saber si estamos cargando un chiste nuevo (útil para mostrar un indicador de carga).

  // Constructor: Nada más nacer esta clase, pedimos el primer chiste
  JokeProvider() {
    fetchNewJoke();// Llamamos a la función que trae el chiste al crear el provider
  }

  // Función que llamaremos cada vez que pulsemos el botón
  Future<void> fetchNewJoke() async {
    isLoading = true; // cambiamos el estado a "cargando"
    notifyListeners(); // primera petición: el notifyListeners! grita: "¡Pantalla, estoy cargando un nuevo chiste, hazme un indicador de carga!"

// aqui usamos un try catch para manejar posibles errores al traer el chiste (como problemas de conexión)
    try {
      final service = JokeService(); // Creamos una instancia del servicio que sabe cómo traer chistes
      currentJoke = await service.getRandomJoke(); // creamos el currentJoke con el chiste que nos devuelve el servicio (esto es una operación asíncrona, por eso usamos 'await')
    } catch (e) {
      print("Error: $e");// Si hay un error, lo imprimimos en la consola.
    }

    isLoading = false; //cambiamos el estado a "no cargando" ya que tenemos el chiste.
    notifyListeners(); // segunda petición: "¡Pantalla, ya lo tengo, dibuja el chiste nuevo!"
  }
}