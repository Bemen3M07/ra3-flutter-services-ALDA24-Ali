import 'package:flutter/material.dart';
import '/modelo/joke_model.dart';
import '/servicio/joke_service.dart';

// El "ChangeNotifier" permite que esta clase AVISE a la pantalla cuando haya cambios
class JokeProvider extends ChangeNotifier {
  JokeModel? currentJoke; // Guardamos el chiste actual (el '?' significa que al principio puede estar vacío/nulo)
  bool isLoading = false; // bool para saber si estamos cargando un chiste nuevo (útil para mostrar un indicador de carga).

  // Constructor: Nada más nacer esta clase, pedimos el primer chiste
  JokeProvider() {
    fetchNewJoke();
  }

  // Función que llamaremos cada vez que pulsemos el botón
  Future<void> fetchNewJoke() async {
    isLoading = true;
    notifyListeners(); // Grito 1: "¡Pantalla, ponte a dar vueltas que estoy cargando!"

    try {
      final service = JokeService();
      currentJoke = await service.getRandomJoke(); // El mensajero nos trae un chiste
    } catch (e) {
      print("Error: $e");
    }

    isLoading = false;
    notifyListeners(); // Grito 2: "¡Pantalla, ya lo tengo, dibuja el chiste nuevo!"
  }
}