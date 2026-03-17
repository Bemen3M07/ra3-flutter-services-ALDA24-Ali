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
      debugShowCheckedModeBanner: false,
      title: 'App de Chistes',
      // ¡Aquí está la magia! En vez de escribir todo el diseño aquí, 
      // le decimos que cargue el archivo joke_screen.dart
      home: JokeScreen(), 
    );
  }
}