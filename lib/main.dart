import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controlador/joke_provider.dart'; // Importamos el controlador
import 'vista/joke_screen.dart'; // Importamos la pantalla que tiene el diseño

void main() {
  runApp(
    // Envolvemos la app con el Provider de los chistes
    ChangeNotifierProvider(
      create: (context) => JokeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Esto quita la etiqueta de "debug" que aparece en la esquina de la pantalla cuando estamos en modo desarrollo.
      title: 'App de Chistes',
      home: JokeScreen(), //solo añadimos la pantalla principal que es el JokeScreen, que es donde se muestra el chiste y el botón.
    );
  }
}