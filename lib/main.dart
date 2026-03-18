import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// IMPORTAMOS LOS ARCHIVOS NUEVOS DE TMB
import 'controlador/tmb_provider.dart'; 
import 'vista/tmb_screen.dart'; 

void main() {
  runApp(
    // 2. CONTRATAMOS AL JEFE DE SALA DE LOS AUTOBUSES
    ChangeNotifierProvider(
      create: (context) => TmbProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      title: 'App de Autobuses TMB',
      // LE DECIMOS A LA APP QUE ABRA DIRECTAMENTE
      home: TmbScreen(), 
    );
  }
}