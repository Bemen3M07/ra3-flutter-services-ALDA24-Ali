import 'package:flutter/material.dart';
import '../modelo/tmb_model.dart'; // Importamos el molde
import '../servicio/tmb_service.dart'; // Importamos al mensajero

class TmbProvider with ChangeNotifier {
  
  List<TmbBusModel> _buses = []; // Aquí guardaremos los autobuses cuando lleguen
  bool _isLoading = false;       // ¿Está el mensajero fuera? (Para mostrar la ruedita de carga)
  String _errorMessage = '';     // Por si hay algún problema (ej. parada que no existe)

  // Dejamos que la pantalla (los camareros) puedan LEER las pizarras, pero no borrarlas
  List<TmbBusModel> get buses => _buses;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Contratamos a nuestro mensajero
  final TmbService _tmbService = TmbService();
  
  // Esta es la función que llamaremos cuando el usuario pulse el botón de "Buscar"
  Future<void> fetchBuses(String stopCode) async {
    // 1. Preparativos antes de mandar al mensajero
    _isLoading = true; // Encendemos la ruedita de carga
    _errorMessage = ''; // Limpiamos errores anteriores
    _buses = []; // Limpiamos la lista por si había datos de otra parada vieja
    notifyListeners(); // actualicen la pantalla y pongan la ruedita.

    try {
      // (Aquí el código se "pausa" esperando a que vuelva gracias al await)
      _buses = await _tmbService.getBuses(stopCode);
      
    } catch (e) {
      // 3. Si el mensajero pincha una rueda o TMB está caído...
      _errorMessage = 'Vaya, no hemos encontrado esa parada o hay un error.';
    } finally {
      // 4. Pase lo que pase (éxito o error), el mensajero ya ha vuelto
      _isLoading = false; // Apagamos la ruedita de carga
      notifyListeners(); // quiten la ruedita y dibujen los datos (o el error)!"
    }
  }
}