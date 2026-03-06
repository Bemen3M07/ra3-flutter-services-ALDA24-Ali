import 'package:flutter_hello_world/http/car_http_service.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('CarsApi', () {
    test('get cars', () async {
      final carHttpService = CarHttpService(); // Creamos a nuestro mensajero
      final cars = await carHttpService.getCars(); // Lo mandamos a internet
      
      // Comprobamos si nos ha traído exactamente 10 coches
      expect(cars.length, 10);
      
      // Comprobamos si el ID del primer coche es el 9582 (como viste en Postman)
      expect(cars[0].id, 9582); 
    });
  });
}