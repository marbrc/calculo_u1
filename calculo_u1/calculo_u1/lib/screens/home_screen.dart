import 'package:flutter/material.dart';
import '../data/unidad1.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import 'actividad_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) => Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            _encabezado(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tu plan de estudio',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.marino)),
                  const SizedBox(height: 12),
                  for (final a in unidad1) _tarjetaActividad(context, a),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Encabezado: título, racha, porcentaje de progreso y barra.
  Widget _encabezado() {
    final pct = (progress.progresoTotal * 100).round();
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.marino, AppColors.marinoClaro],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cálculo de\nVarias Variables',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20)),
                child: Text('🔥 ${progress.racha} días',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Unidad 1 · Progreso: $pct%',
              style: const TextStyle(color: Colors.white70, fontSize: 15)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.progresoTotal,
              minHeight: 10,
              backgroundColor: Colors.white24,
              color: AppColors.menta,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaActividad(BuildContext context, Actividad a) {
    final aprobada = progress.aprobada(a.id);
    final esFinal = a.id == 'eval'; // la evaluación final se ve distinta
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: esFinal ? 6 : 2,
      color: esFinal ? AppColors.marino : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: Text(a.emoji, style: const TextStyle(fontSize: 32)),
        title: Text(a.titulo,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: esFinal ? Colors.white : null)),
        subtitle: Text('${a.descripcion}\nMejor quiz: ${progress.mejor(a.id)}%',
            style: TextStyle(color: esFinal ? Colors.white70 : null)),
        isThreeLine: true,
        trailing: Icon(aprobada ? Icons.check_circle : Icons.chevron_right,
            color: aprobada
                ? AppColors.menta
                : (esFinal ? Colors.white : AppColors.marino)),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => ActividadScreen(actividad: a))),
      ),
    );
  }
}
