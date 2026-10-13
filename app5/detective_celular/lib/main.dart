
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class Pregunta {
  final String texto;
  final List<String> opciones;
  final int correcta;
  const Pregunta(this.texto, this.opciones, this.correcta);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JuegoHardware(),
    );
  }
}

class JuegoHardware extends StatefulWidget {
  const JuegoHardware({super.key});

  @override
  State<JuegoHardware> createState() => _JuegoHardwareState();
}

class _JuegoHardwareState extends State<JuegoHardware> {
  final preguntas = const [
    Pregunta('¿Qué componente permite conocer la posición aproximada?', ['Cámara', 'GPS', 'Bocina', 'Pantalla'], 1),
    Pregunta('¿Qué componente guarda datos temporalmente?', ['RAM', 'Micrófono', 'Flash', 'Acelerómetro'], 0),
    Pregunta('¿Qué sensor detecta rotación u orientación?', ['Giroscopio', 'Altavoz', 'SIM', 'NFC'], 0),
    Pregunta('¿Qué componente captura imágenes?', ['Vibrador', 'Cámara', 'CPU', 'WiFi'], 1),
    Pregunta('¿Qué tecnología permite conectar dispositivos inalámbricamente a corta distancia?', ['GPS', 'Bluetooth', 'CPU', 'RAM'], 1),
    Pregunta('¿Qué tecnología permite la comunicación por proximidad?', ['NFC', 'WiFi', 'Flash', 'Cámara'], 0),
    Pregunta('¿Qué memoria almacena datos de forma permanente?', ['RAM', 'Caché', 'Flash', 'CPU'], 2),
    Pregunta('¿Qué componente procesa las instrucciones del celular?', ['Pantalla', 'CPU', 'Bocina', 'GPS'], 1),
    Pregunta('Qué sensor detecta el movimiento del celular?', ['Acelerómetro', 'Micrófono', 'NFC', 'Flash'], 0),
    Pregunta('Qué senso detecta cuando acercas el celular a tu cara?', ['GPS', 'Giroscopio', 'Proximidad', 'Bluetooth'], 2),
  ];

  int indice = 0, puntos = 0;
  bool terminado = false;

  void responder(int opcion) {
    if (indice >= preguntas.length) return;

    setState(() {
      if (opcion == preguntas[indice].correcta) puntos += 10;
      indice++;
      if (indice >= preguntas.length) terminado = true;
    });
  }

  void reiniciar() {
    setState(() {
      indice = 0;
      puntos = 0;
      terminado = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detective del celular')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: terminado
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('¡Juego terminadoooooooooooo!\nPunteeees: $puntos',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: reiniciar,
                    child: const Text('Jugar de nuevo'),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Puntos: $puntos'),
                  Text('Pregunta ${indice + 1} de ${preguntas.length}'),
                  const SizedBox(height: 20),
                  Text(preguntas[indice].texto,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  for (int i = 0; i < preguntas[indice].opciones.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () => responder(i),
                        child: Text(preguntas[indice].opciones[i]),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}