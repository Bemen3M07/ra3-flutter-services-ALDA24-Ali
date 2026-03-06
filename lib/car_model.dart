//FUNCION DE ESTE CODIGO:
//Cuando internet nos envía datos, nos los manda en un texto enorme llamado JSON. 
//Flutter no sabe leer eso directamente, así que esta clase lo traduce!


// Necesitamos importar esta librería de Dart para traducir los textos JSON
import 'dart:convert'; 

// Aquí empieza la clase de coche, con sus propiedades y métodos para convertirlo a y desde JSON. Esto, obviamente tiene que estar adaptado a la estructura de los datos que nos devuelve la API
//  (si nos fijamos en Postman, cada coche tiene un ID, un año, una marca, un modelo y un tipo, así que aquí lo reflejamos)
class CarsModel {
  //En esta llave creamos el constructor de la clase, que es lo que usaremos para crear objetos de tipo coche a partir de los datos que nos devuelve la API.
  CarsModel({
    required this.id,
    required this.year,
    required this.make,
    required this.model,
    required this.type,
  });

// Estas son las propiedades de cada coche, que coinciden con los datos que nos devuelve la API
//el final significa que estas propiedades no pueden cambiar una vez que el coche ha sido creado (son inmutables).
  final int id; 
  final int year;
  final String make;
  final String model;
  final String type;

//el factory es un tipo especial de constructor que se usa para crear objetos a partir de otros formatos, en este caso a partir de un mapa (que es lo que obtenemos al traducir el JSON).
// es decir, esta función coge un mapa con los datos de un coche y devuelve un objeto de tipo CarsModel con esos datos.
//fromMapToCarObject es un nombre que le he dado a esta función, pero podrías llamarla como quieras. Lo importante es que reciba un Map<String, dynamic> (que es el formato que obtenemos al traducir el JSON) y devuelva un CarsModel.
 // fromMapToCarObject se crea directamente en este código, pero también podríamo
 
  factory CarsModel.fromMapToCarObject(Map<String, dynamic> json) => CarsModel(
    id: json["id"],
    year: json["year"],
    make: json["make"],
    model: json["model"],
    type: json["type"],
  );

  Map<String, dynamic> fromObjectToMap() => {
    "id": id,
    "year": year,
    "make": make,
    "model": model,
    "type": type,
  };
}

// Coge el texto de internet (String str) y devuelve una Lista de CarsModel
List<CarsModel> carsModelFromJson(String str) => List<CarsModel>.from(
    json.decode(str).map((x) => CarsModel.fromMapToCarObject(x)));

// Esta hace lo contrario (por si algún día quieres enviar coches a internet)
String carsModelToJson(List<CarsModel> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.fromObjectToMap())));