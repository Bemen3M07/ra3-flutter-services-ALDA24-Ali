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
              return const CircularProgressIndicator();
            }

            // Si por algún motivo no hay chiste, mostramos un mensaje
            if (provider.currentJoke == null) {
              return const Text('Error al cargar el chiste');
            }

            // Si todo va bien, dibujamos los textos y el botón
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical
                children: [
                  Text(
                    provider.currentJoke!.setup,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20), // Un espacio en blanco de separación
                  Text(
                    provider.currentJoke!.punchline,
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40), // Más espacio en blanco
                  
                  // ¡EL BOTÓN MÁGICO!
                  ElevatedButton(
                    onPressed: () {
                      // Al pulsar, le decimos al controlador que vaya a por otro
                      provider.fetchNewJoke(); 
                    },
                    child: const Text('¡Dame otro chiste!'),
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