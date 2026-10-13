
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Semaforo(),
    );
  }
}

class Semaforo extends StatefulWidget {
  const Semaforo({super.key});

  @override
  State<Semaforo> createState() => _SemaforoAguaState();
}

class _SemaforoAguaState extends State<Semaforo> {
  int nivel = 0;
  String mensaje = 'Presiona un boton para comenzar';

  void cambiarNivel() {
    setState(() {
      nivel++;

      if (nivel > 3) nivel = 0;

      if (nivel == 0) {
        mensaje = 'Excelente ahorro de agua';
      } else if (nivel == 1) {
        mensaje = 'Tu consumo es responsable';
      } else if (nivel == 2) {
        mensaje = 'Ten cuidado con el consumo';
      } else {
        mensaje = 'Consumo excesivo';
      }
    });
  }

  Color cambiarColor(int nivel) {
    switch (nivel) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semaforo de Agua'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              size: 30,
              color: cambiarColor(nivel),
            ),
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: cambiarNivel,
              child: const Text('Cambiar nivel'),
            ),
          ],
        ),
      ),
    );
  }
}