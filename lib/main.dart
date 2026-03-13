import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importamos el provider
import 'car_provider.dart'; // Importamos tu almacén

void main() {
  runApp(
    // 1. Envolvemos TODA la aplicación en el Provider para que las pantallas tengan acceso a los datos
    ChangeNotifierProvider(
      create: (context) => CarProvider(), //en esta función le decimos que queremos usar el CarProvider como almacén de datos
      child: const MyApp(),// Aquí va el resto de nuestra aplicación, que ahora tiene acceso a CarProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,// Adiós a la molesta etiqueta de "debug" en la esquina
      title: 'App de Coches',
      home: Scaffold(// La estructura básica de la pantalla
        appBar: AppBar(//es la barra superior de la aplicación
          title: const Text('Lista de Coches'),
          backgroundColor: Colors.blue,
        ),
        body: Consumer<CarProvider>( //en el body de la pantalla, usamos un Consumer para escuchar los cambios en CarProvider, esto nos permite actualizar la pantalla automáticamente cuando los datos cambian.
          builder: (context, provider, child) {//aqui incluimos el provider como parámetro para poder acceder a sus datos en el builder que es donde dibujamos la pantalla
            
            // Si está cargando, mostramos la ruedita de carga
            if (provider.isLoading) {//el isloading es una variable booleana que se pone en true cuando estamos cargando los datos, y en false cuando ya los tenemos, esto nos permite mostrar un indicador de carga mientras esperamos la respuesta del servidor
              return const Center(child: CircularProgressIndicator()); // CircularProgressIndicator es esa ruedita giratoria que indica que algo se está cargando y Center es un widget que centra su hijo en la pantalla
            }
            
            // Si la lista está vacía por algún error
            if (provider.cars.isEmpty) {//el provider se saca del parámetro del builder, y cars es la lista de coches que tenemos en el CarProvider, si esa lista está vacía, mostramos un mensaje de error
              return const Center(child: Text('No se encontraron coches.'));//sino sale un mensaje de error, y Center es para centrar el mensaje en la pantalla
            }

            // usamos listview para dibujar cada elemento de la lista
            return ListView.builder(//el return de ListView.builder es para dibujar una lista de elementos, y el builder es una función que se llama para cada elemento de la lista, y nos da el contexto y el índice del elemento actual
              itemCount: provider.cars.length, // Le decimos cuántos coches hay con itemCount, que es la longitud de la lista de coches en el provider
              itemBuilder: (context, index) {//y con itemBuilder le decimos cómo dibujar cada elemento de la lista, y nos da el índice del elemento actual para que podamos acceder a él
                final coche = provider.cars[index]; // Sacamos el coche actual del bucle usando el índice, y lo guardamos en una variable para usarlo en el ListTile que la variable es coche, y provider.cars es la lista de coches en el provider, y index es el índice del coche actual en esa lista
                
                // ListTile es un cajetín que ya trae Flutter diseñado, es muy útil para mostrar listas de cosas, porque ya tiene un diseño predefinido con un icono a la izquierda, un título principal, un subtítulo debajo, y otras cosas que podemos usar
                return ListTile(
                  leading: const Icon(Icons.directions_car, color: Colors.blue), // el leading es el icono que va a la izquierda del ListTile, en este caso usamos un icono de coche de Flutter, y le damos un color azul para que se vea bonito
                  title: Text('${coche.make} ${coche.model}'), // este es el titulo principal del ListTile, donde mostramos la marca y el modelo del coche, que estan guardados en las propiedades make y model del coche, y usamos la sintaxis de ${} para insertar esas variables dentro del texto.
                  subtitle: Text('Año: ${coche.year} - Tipo: ${coche.type}'), // Subtítulo del ListTile, donde mostramos el año y el tipo del coche, que estan guardados en las propiedades year y type del coche, y usamos la misma sintaxis de ${} para insertar esas variables dentro del texto.
                );
              },
            );
          },
        ),
      ),
    );
  }
}