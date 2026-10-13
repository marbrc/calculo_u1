import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

/// Lecciones del tema. Si la lección tiene videoUrl (en data/unidad1.dart)
/// aparece el botón de video; si no, "Video próximamente".
class LeccionScreen extends StatelessWidget {
  final Actividad actividad;
  const LeccionScreen({super.key, required this.actividad});

  Future<void> _abrir(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tema · ${actividad.titulo}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final l in actividad.lecciones) ...[
            Text(l.titulo,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.marino)),
            const SizedBox(height: 10),
            _video(l),
            const SizedBox(height: 12),
            for (final b in l.bloques) _bloque(b),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _video(Leccion l) {
    final hay = l.videoUrl != null && l.videoUrl!.isNotEmpty;
    return InkWell(
      onTap: hay ? () => _abrir(l.videoUrl!) : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: hay
              ? AppColors.marino
              : AppColors.marinoClaro.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: hay
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_fill, color: Colors.white, size: 52),
                    SizedBox(height: 6),
                    Text('Ver video',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                )
              : const Text('🎬 Video próximamente',
                  style: TextStyle(color: AppColors.marino)),
        ),
      ),
    );
  }

  Widget _bloque(String texto) {
    final esEjemplo = texto.startsWith('EJEMPLO');
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: esEjemplo ? AppColors.cielo.withValues(alpha: 0.2) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(texto, style: const TextStyle(fontSize: 16, height: 1.4)),
    );
  }
}
