import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  final Actividad actividad;
  const QuizScreen({super.key, required this.actividad});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _i = 0; // pregunta actual
  int _aciertos = 0;
  int? _elegida; // opción elegida (null = aún no responde)
  bool _terminado = false;

  List<Pregunta> get _preguntas => widget.actividad.quiz;

  void _responder(int op) {
    if (_elegida != null) return; // evita doble toque
    setState(() {
      _elegida = op;
      if (op == _preguntas[_i].correcta) _aciertos++;
    });
  }

  Future<void> _siguiente() async {
    if (_i < _preguntas.length - 1) {
      setState(() {
        _i++;
        _elegida = null;
      });
    } else {
      final pct = (_aciertos * 100 / _preguntas.length).round();
      await progress.guardarQuiz(widget.actividad.id, pct);
      setState(() => _terminado = true);
    }
  }

  void _reintentar() => setState(() {
        _i = 0;
        _aciertos = 0;
        _elegida = null;
        _terminado = false;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz · ${widget.actividad.titulo}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _terminado ? _resultado() : _pregunta(),
      ),
    );
  }

  Widget _pregunta() {
    final p = _preguntas[_i];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearProgressIndicator(
            value: (_i + 1) / _preguntas.length, color: AppColors.cielo),
        const SizedBox(height: 20),
        Text(p.texto,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.marino)),
        const SizedBox(height: 16),
        for (int k = 0; k < p.opciones.length; k++) _boton(p, k),
        if (_elegida != null) ...[
          const SizedBox(height: 12),
          Text(p.explicacion, style: const TextStyle(fontSize: 15)),
          const Spacer(),
          ElevatedButton(
              onPressed: _siguiente,
              child:
                  Text(_i < _preguntas.length - 1 ? 'Siguiente' : 'Terminar')),
        ],
      ],
    );
  }

  /// Verde si es la correcta, coral si la elegida estaba mal.
  Widget _boton(Pregunta p, int k) {
    Color color = Colors.white;
    if (_elegida != null) {
      if (k == p.correcta) {
        color = AppColors.menta.withOpacity(0.4);
      } else if (k == _elegida) {
        color = AppColors.coral.withOpacity(0.4);
      }
    }
    return Card(
      color: color,
      child: ListTile(title: Text(p.opciones[k]), onTap: () => _responder(k)),
    );
  }

  Widget _resultado() {
    final pct = (_aciertos * 100 / _preguntas.length).round();
    final paso = pct >= 70;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(paso ? '🎉' : '📚', style: const TextStyle(fontSize: 64)),
        Text('$pct%',
            style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.marino)),
        Text(paso
            ? '¡Aprobaste! Racha sumada 🔥'
            : 'Repasa el tema y vuelve a intentar'),
        const SizedBox(height: 24),
        if (!paso)
          ElevatedButton(onPressed: _reintentar, child: const Text('Reintentar')),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Volver')),
      ],
    );
  }
}
