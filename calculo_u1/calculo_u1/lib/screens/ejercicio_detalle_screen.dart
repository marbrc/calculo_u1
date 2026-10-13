import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/soluciones.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

/// Un ejercicio: pistas → proceso → resultado → foto → retroalimentación.
class EjercicioDetalleScreen extends StatefulWidget {
  final Actividad actividad;
  final Ejercicio ejercicio;
  const EjercicioDetalleScreen(
      {super.key, required this.actividad, required this.ejercicio});

  @override
  State<EjercicioDetalleScreen> createState() => _EjercicioDetalleState();
}

class _EjercicioDetalleState extends State<EjercicioDetalleScreen> {
  late final String _clave = '${widget.actividad.id}-${widget.ejercicio.numero}';
  late final Solucion? _sol = soluciones[_clave];
  final _proceso = TextEditingController();
  final _resultado = TextEditingController();

  int _pistasVistas = 0;
  bool _revisado = false;
  bool? _acierto; // true / false / null (no se puede validar sola)
  Uint8List? _foto;

  @override
  void initState() {
    super.initState();
    // Recupera lo que escribió la última vez
    _proceso.text = progress.texto('proc_$_clave');
    _resultado.text = progress.texto('res_$_clave');
  }

  @override
  void dispose() {
    _proceso.dispose();
    _resultado.dispose();
    super.dispose();
  }

  /// Quita espacios, acentos y símbolos para comparar respuestas.
  String _norm(String s) {
    var t = s.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    const de = 'áéíóú', a = 'aeiou';
    for (var i = 0; i < de.length; i++) {
      t = t.replaceAll(de[i], a[i]);
    }
    return t.replaceAll('−', '-').replaceAll('√', 'sqrt');
  }

  Future<void> _elegirFoto(ImageSource fuente) async {
    final x = await ImagePicker().pickImage(source: fuente, imageQuality: 80);
    if (x == null) return;
    final bytes = await x.readAsBytes(); // funciona en web y en celular
    setState(() => _foto = bytes);
  }

  Future<void> _revisar() async {
    if (_resultado.text.trim().isEmpty && _foto == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Escribe tu resultado o sube la foto primero 😉')));
      return;
    }
    await progress.guardarTexto('proc_$_clave', _proceso.text);
    await progress.guardarTexto('res_$_clave', _resultado.text);

    bool? ok;
    final s = _sol;
    if (s != null && s.aceptadas.isNotEmpty && _resultado.text.trim().isNotEmpty) {
      ok = s.aceptadas.map(_norm).contains(_norm(_resultado.text));
    }
    if (ok == true) {
      await progress.marcarEjercicio(
          widget.actividad.id, widget.ejercicio.numero, true);
    } else {
      await progress.registrarEstudio(); // intentar también cuenta para la racha
    }
    setState(() {
      _revisado = true;
      _acierto = ok;
    });
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.ejercicio;
    final s = _sol;
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio ${e.numero}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tarjeta(
            color: AppColors.marino,
            hijo: Text('${e.indicacion}\n\n${e.enunciado}',
                style: const TextStyle(
                    color: Colors.white, fontSize: 17, height: 1.4)),
          ),
          const SizedBox(height: 16),

          // ── PISTAS ──
          if (s != null) ...[
            const _Titulo('💡 Pistas'),
            for (var i = 0; i < _pistasVistas; i++)
              _tarjeta(
                color: AppColors.cielo.withValues(alpha: 0.2),
                hijo: Text('Pista ${i + 1}: ${s.pistas[i]}',
                    style: const TextStyle(fontSize: 16, height: 1.4)),
              ),
            if (_pistasVistas < s.pistas.length)
              OutlinedButton.icon(
                onPressed: () => setState(() => _pistasVistas++),
                icon: const Icon(Icons.lightbulb_outline),
                label: Text(
                    'Dame una pista (${_pistasVistas}/${s.pistas.length})'),
              ),
            const SizedBox(height: 20),
          ],

          // ── PROCESO Y RESULTADO ──
          const _Titulo('✍️ Mi proceso'),
          TextField(
            controller: _proceso,
            maxLines: 6,
            decoration: _campo('Escribe aquí tu desarrollo paso a paso'),
          ),
          const SizedBox(height: 12),
          const _Titulo('🎯 Mi resultado'),
          TextField(
            controller: _resultado,
            decoration: _campo('Ej: 4   |   no existe   |   sqrt7'),
          ),
          const SizedBox(height: 20),

          // ── FOTO ──
          const _Titulo('📸 Foto de mi hoja'),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _elegirFoto(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Galería'),
                ),
              ),
              if (!kIsWeb) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _elegirFoto(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: const Text('Cámara'),
                  ),
                ),
              ],
            ],
          ),
          if (_foto != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.memory(_foto!)),
          ],
          const SizedBox(height: 20),

          ElevatedButton(onPressed: _revisar, child: const Text('Revisar ✅')),
          const SizedBox(height: 20),

          if (_revisado) _retroalimentacion(s),
        ],
      ),
    );
  }

  /// Retroalimentación: resultado + solución paso a paso.
  Widget _retroalimentacion(Solucion? s) {
    String titulo;
    Color color;
    if (_acierto == true) {
      titulo = '🎉 ¡Tu resultado coincide! Ejercicio marcado como hecho.';
      color = AppColors.menta.withValues(alpha: 0.35);
    } else if (_acierto == false) {
      titulo = '🤔 Tu resultado no coincide con el esperado (o lo escribiste '
          'distinto). Compara tus pasos con la solución.';
      color = AppColors.coral.withValues(alpha: 0.3);
    } else {
      titulo = '📋 Compara tu proceso y tu foto con la solución.';
      color = AppColors.cielo.withValues(alpha: 0.25);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Titulo('🧾 Retroalimentación'),
        _tarjeta(
            color: color,
            hijo: Text(titulo,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold))),
        if (s != null) ...[
          _tarjeta(
            color: Colors.white,
            hijo: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Solución paso a paso',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.marino)),
                const SizedBox(height: 8),
                for (final p in s.pasos)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('• $p',
                        style: const TextStyle(fontSize: 15, height: 1.4)),
                  ),
                const Divider(),
                Text('Resultado: ${s.resultado}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
        if (_foto != null)
          _tarjeta(
            color: Colors.white,
            hijo: const Text(
              '📸 Tu foto se muestra arriba. Revísala contra los pasos de la '
              'solución: ¿tienes cada paso y el resultado final? '
              '(La revisión automática de la foto con IA llega en la siguiente etapa.)',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        if (_acierto != true)
          ElevatedButton(
            onPressed: () async {
              await progress.marcarEjercicio(
                  widget.actividad.id, widget.ejercicio.numero, true);
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Mi resultado sí coincide → marcar como hecho'),
          ),
      ],
    );
  }

  InputDecoration _campo(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
      );

  Widget _tarjeta({required Color color, required Widget hijo}) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
        child: hijo,
      );
}

class _Titulo extends StatelessWidget {
  final String texto;
  const _Titulo(this.texto);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(texto,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.marino)),
      );
}
