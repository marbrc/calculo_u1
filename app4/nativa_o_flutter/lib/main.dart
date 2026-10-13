
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  void verificar(BuildContext context, String respuesta) {
    if (respuesta == 'Flutter') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '¡Correcto! Flutter permite compartir gran parte del código.',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrecto, intenta de nuevo.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nativa o Flutter?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Una app debe funcionar en Android y iOS con un solo equipo de desarrollo. ¿Qué tecnología permite compartir gran parte del código?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => verificar(context, 'Android'),
              child: const Text('Android'),
            ),

            ElevatedButton(
              onPressed: () => verificar(context, 'iOS Nativo'),
              child: const Text('iOS Nativo'),
            ),

            ElevatedButton(
              onPressed: () => verificar(context, 'Flutter'),
              child: const Text('Flutter'),
            ),
          ],
        ),
      ),
    );
  }
}