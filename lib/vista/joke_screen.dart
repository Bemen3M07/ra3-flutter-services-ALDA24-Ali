import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controlador/joke_provider.dart';

class JokeScreen extends StatelessWidget {
  const JokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chistes Aleatorios'),
        backgroundColor: Colors.orange,
      ),
      // Centramos todo en la pantalla
      body: Center(
        // El Consumer es el que "escucha" los gritos del JokeProvider
        child: Consumer<JokeProvider>(
          builder: (context, provider, child) {
            
            // Si el semáforo de carga está en true, mostramos la ruedita
            if (provider.isLoading) {
              return const CircularProgressIndicator();//Es la ruedita de carga.
            }

            // Si por algún motivo no hay chiste, mostramos un mensaje
            if (provider.currentJoke == null) {
              return const Text('Error al cargar el chiste');
            }

            // Si todo va bien, dibujamos los textos y el botón
            return Padding( //devolvemos el padding que es el espacio entre el borde de la pantalla y el contenido
              padding: const EdgeInsets.all(20.0), //aqui definimos el espacio entre el borde de la pantalla y el contenido y el edgeinsets.all es para decir que queremos el mismo espacio en todos los lados, y el 20.0 es la cantidad de espacio en pixeles.
              child: Column(//El column es un widget que nos permite colocar varios widgets uno debajo de otro, y el mainAxisAlignment.center es para centrar los widgets verticalmente.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(// Aquí mostramos el setup del chiste, con un estilo grande y negrita
                    provider.currentJoke!.setup,//aqui ponemos esto para mostrar el setup del chiste, y el signo de exclamación es para decirle a Dart que estamos seguros de que currentJoke no es nulo, porque si lo fuera, nos daría un error.
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),//imponemos un estilo de texto con un tamaño de 24 y negrita.
                    textAlign: TextAlign.center, //centramos el texto con el textAlign.center.
                  ),
                  const SizedBox(height: 20), // Un espacio en blanco de separación
                  Text(
                    provider.currentJoke!.punchline,//aqui mostramos el punchline del chiste, con un estilo un poco más pequeño y en azul.
                    style: const TextStyle(fontSize: 20, color: Colors.blue),//imponemos un estilo de texto con un tamaño de 20 y color azul.
                    textAlign: TextAlign.center,//centramos el texto con el textAlign.center.
                  ),
                  const SizedBox(height: 40), // Más espacio en blanco
                  
                  // EL BOTÓN:
                  ElevatedButton(
                    onPressed: () {//si el botón es pulsado, se ejecuta esta función, que le dice al provider que traiga un nuevo chiste.
                      // Al pulsar, le decimos al controlador que vaya a por otro
                      provider.fetchNewJoke(); //esta función es la que tenemos en el JokeProvider que se encarga de traer un nuevo chiste y actualizar la pantalla.
                    },
                    child: const Text('¡Dame otro chiste!'),//el child es el contenido del botón, que en este caso es un texto que dice "¡Dame otro chiste!".
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}