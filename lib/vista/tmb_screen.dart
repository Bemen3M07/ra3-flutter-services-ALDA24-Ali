import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controlador/tmb_provider.dart'; // Importamos al Jefe de Sala

class TmbScreen extends StatelessWidget {
  // 1. LA LIBRETA DEL CAMARERO: Aquí apuntaremos lo que el usuario escriba
  final TextEditingController _stopCodeController = TextEditingController();

  TmbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMB - Tiempos de Autobús '),
        backgroundColor: Colors.redAccent, // Color de los buses de Barcelona!
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // CAJA DE TEXTO PARA ESCRIBIR LA PARADA ---
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _stopCodeController, // Le damos la libreta a la caja de texto
                    keyboardType: TextInputType.number, // Que solo salga el teclado numérico
                    decoration: const InputDecoration(
                      labelText: 'Código de parada (ej: 2775)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                
                //  BOTÓN DE BUSCAR ---
                ElevatedButton(
                  onPressed: () {
                    // Cuando pulsamos, leemos lo que hay en la libreta y llamamos al Jefe de Sala
                    final stopCode = _stopCodeController.text;
                    if (stopCode.isNotEmpty) {
                      // context.read sirve para dar una orden al Provider sin quedarse escuchando
                      context.read<TmbProvider>().fetchBuses(stopCode);
                    }
                  },
                  child: const Text('Buscar'),
                ),
              ],
            ),
            
            const SizedBox(height: 20),

            // LA ZONA DONDE APARECEN LOS AUTOBUSES (El Consumer) ---
            // El Consumer es el camarero que se queda con la oreja pegada al megáfono del Jefe de Sala
            Expanded(
              child: Consumer<TmbProvider>(
                builder: (context, tmbProvider, child) {
                  // Caso A: El mensajero está de camino (Ruedita de carga)
                  if (tmbProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Caso B: El mensajero volvió con un error o la parada no existe
                  if (tmbProvider.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        tmbProvider.errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }

                  // Caso C: El mensajero volvió sin errores, pero la lista está vacía (Aún no hemos buscado)
                  if (tmbProvider.buses.isEmpty) {
                    return const Center(
                      child: Text('Escribe un código de parada y pulsa Buscar'),
                    );
                  }

                  // Caso D: ¡EL MENSAJERO TRAJO LOS AUTOBUSES! Dibujamos la lista
                  return ListView.builder(
                    itemCount: tmbProvider.buses.length,
                    itemBuilder: (context, index) {
                      final bus = tmbProvider.buses[index]; // Sacamos el bus correspondiente

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Text(
                              bus.line,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text('Destino: ${bus.destination}'),
                          subtitle: Text(
                            'Tiempo de espera: ${bus.timeText}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}