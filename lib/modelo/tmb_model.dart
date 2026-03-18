
//a la hora de crear esta clase, tenemo en cuenta los atributos de la API de TMB que vamos a usar, que son el número de línea, el destino y el tiempo que falta para que llegue el bus.

class TmbBusModel {
  final String line;
  final String destination;
  final String timeText; // Aquí creamos la variable timeText para guardar el texto que nos dice cuánto falta para que llegue el bus, que es el campo "text-ca" que vimos en Postman. Lo hacemos como String porque viene con el formato "5 min" o "Llegando", y no solo un número.
  
  // Constructor para crear un objeto TmbBusModel con los datos que recibimos de internet
  TmbBusModel({
    required this.line,
    required this.destination,
    required this.timeText,
  });

  // Fábrica para traducir el JSON de internet a nuestro objeto TmbBusModel
  factory TmbBusModel.fromJson(Map<String, dynamic> json) { //el factory significa en el lenguaje de Dart que esta función es una fábrica que se encarga de crear objetos de tipo TmbBusModel a partir de un JSON, que es el formato en el que recibimos los datos de internet. El Map<String, dynamic> es el formato del JSON, donde las claves son strings y los valores pueden ser de cualquier tipo.
    return TmbBusModel(//aquí dentro del return es donde asignamos los valores de nuestro objeto TmbBusModel a partir de los campos del JSON que recibimos de internet. Usamos el operador ?? para darle un valor por defecto en caso de que el campo venga nulo, para evitar errores.
      line: json['line'] ?? 'Desconocida', // El ?? es por si viene nulo, que no explote
      destination: json['destination'] ?? 'Desconocido',
      timeText: json['text-ca'] ?? '?? min', // Usamos el campo text-ca que vimos en Postman
    );
  }
}