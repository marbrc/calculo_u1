import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import 'ejercicio_detalle_screen.dart';

/// Lista de ejercicios de la hoja. Al tocar uno se abre el detalle
/// (pistas, proceso, resultado, foto y retroalimentación).
class EjerciciosScreen extends StatelessWidget {
  final Actividad actividad;
  const EjerciciosScreen({super.key, required this.actividad});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: Text('Ejercicios · ${actividad.titulo}')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final e in actividad.ejercicios)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  title: Text('${e.numero}. ${e.indicacion}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.marino)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(e.enunciado,
                        style: const TextStyle(fontSize: 16, height: 1.4)),
                  ),
                  trailing: Icon(
                    progress.ejercicioHecho(actividad.id, e.numero)
                        ? Icons.check_circle
                        : Icons.chevron_right,
                    color: progress.ejercicioHecho(actividad.id, e.numero)
                        ? AppColors.menta
                        : AppColors.marino,
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EjercicioDetalleScreen(
                          actividad: actividad, ejercicio: e),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
