import 'dart:convert';

//en este codigo tenemos el molde del chiste, que es la clase JokeModel, con sus propiedades id, setup y punchline, 
//y un constructor que convierte el JSON que recibimos de internet en un objeto de tipo JokeModel. 
//También tenemos una función jokesFromJson que convierte la respuesta de internet, que es un string, 
//en una lista de objetos JokeModel usando la función fromJson de cada chiste.

// para poder convertir el JSON que recibimos de internet en un objeto que podamos usar en nuestro código, necesitamos un molde, que es esta clase JokeModel.
class JokeModel {
  JokeModel({
    required this.id,
    required this.setup,
    required this.punchline,
  });

//aqui son las propiedades del chiste, que son el id, el setup y el punchline, y el constructor que las inicializa.
  final int id;
  final String setup;
  final String punchline;

  // aqui tenemos la función fromJson, que es la que se encarga de convertir el JSON que recibimos de internet en un objeto de tipo JokeModel,
  // y le damos valores por defecto por si el JSON no tiene esos campos o vienen vacíos, para evitar errores.
  factory JokeModel.fromJson(Map<String, dynamic> json) => JokeModel( //el map<string, dynamic> es el formato del JSON que recibimos de internet, donde las claves son strings y los valores pueden ser de cualquier tipo. y la flechita es para decir que esta función devuelve un objeto de tipo JokeModel.
    id: json["id"] ?? 0,//el id del chiste, que es un número entero, y le damos un valor por defecto de 0 por si el JSON no tiene ese campo o viene vacío.
    setup: json["setup"] ?? "Sense text",//el setup del chiste, que es el texto que se muestra antes de la punchline, y le damos un valor por defecto de "Sense text" por si el JSON no tiene ese campo o viene vacío.
    punchline: json["punchline"] ?? "Sense text",//el punchline del chiste, que es el texto que se muestra después del setup, y le damos un valor por defecto de "Sense text" por si el JSON no tiene ese campo o viene vacío. lo hacemos con "??" que es el operador de null-coalescing, que significa "si esto es null, entonces usa esto otro".
  );
}

// aqui tenemos la lista de chistes, que es una función que recibe un string, que es la respuesta de internet, y devuelve una lista de objetos JokeModel usando la función fromJson de cada chiste.
List<JokeModel> jokesFromJson(String str) => //aqui usamos la función jokesFromJson que fue creada en la clase JokeModel, y le pasamos el string que recibimos de internet, que es la respuesta del servidor, y esta función devuelve una lista de objetos JokeModel.
    List<JokeModel>.from(json.decode(str).map((x) => JokeModel.fromJson(x)));//el json.decode(str) es para convertir el string que recibimos de internet en un formato que podamos usar en nuestro código,
                                                                            // que es una lista de mapas, donde cada mapa representa un chiste con sus campos id, setup y punchline. y luego usamos el map para 
                                                                            //recorrer esa lista de mapas y convertir cada mapa en un objeto de tipo JokeModel usando la función fromJson que tenemos en la clase JokeModel. 
                                                                            //finalmente, usamos List<JokeModel>.from para convertir ese iterable que nos da el map en una lista de objetos JokeModel.