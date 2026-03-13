import 'package:flutter/material.dart';
import 'car_model.dart'; // Tu molde
import 'http/car_http_service.dart'; // Tu mensajero

// "ChangeNotifier" es la magia que le permite avisar a la pantalla de los cambios
class CarProvider extends ChangeNotifier {
  List<CarsModel> cars = []; // Aquí guardaremos la lista de coches
  bool isLoading = true; // Un semáforo para mostrar la típica "ruedita de carga"

  // El constructor: en cuanto nazca esta clase, mandamos al mensajero a por los coches
  CarProvider() {
    fetchCars();
  }

  Future<void> fetchCars() async { // El método que se encarga de traer los coches y async significa que es asíncrono, o sea,
  // que puede tardar un poco. y el future<void> es para decir que no devuelve nada, solo hace su trabajo.
    isLoading = true; // Encendemos el semáforo de carga
    notifyListeners(); // Avisamos a la pantalla: "¡Ponte a cargar!"

    try {
      final service = CarHttpService(); // Llamamos al mensajero
      cars = await service.getCars(); // Esperamos los coches
    } catch (e) {
      print("Error: $e");
    }

    isLoading = false;
    notifyListeners(); // Avisamos a la pantalla: "¡Ya tengo los coches, dibújalos!"
  }
}