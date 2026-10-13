import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'ejercicios_screen.dart';
import 'leccion_screen.dart';
import 'quiz_screen.dart';

/// Menú de una actividad: tema, ejercicios y quiz.
class ActividadScreen extends StatelessWidget {
  final Actividad actividad;
  const ActividadScreen({super.key, required this.actividad});

  @override
  Widget build(BuildContext context) {
    void ir(Widget w) =>
        Navigator.push(context, MaterialPageRoute(builder: (_) => w));

    return Scaffold(
      appBar: AppBar(title: Text(actividad.titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(actividad.descripcion,
                style: const TextStyle(fontSize: 16, color: AppColors.marino)),
            const SizedBox(height: 20),
            _opcion('🎬  Ver tema', 'Explicación paso a paso',
                () => ir(LeccionScreen(actividad: actividad))),
            _opcion('📝  Hoja de ejercicios',
                'Resuelve en tu libreta y marca los que lleves',
                () => ir(EjerciciosScreen(actividad: actividad))),
            _opcion('🧠  Quiz de la actividad', 'Necesitas 70% para aprobar',
                () => ir(QuizScreen(actividad: actividad))),
          ],
        ),
      ),
    );
  }

  Widget _opcion(String t, String s, VoidCallback onTap) {
    return Card(
      child: ListTile(
        title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(s),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
