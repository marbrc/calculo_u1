import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/unidad1.dart';

/// Guarda racha, calificaciones y ejercicios hechos en el teléfono.
class ProgressService extends ChangeNotifier {
  late SharedPreferences _p;
  int racha = 0;

  Future<void> cargar() async {
    _p = await SharedPreferences.getInstance();
    racha = _p.getInt('racha') ?? 0;
    _revisarRacha();
  }

  String get _hoy => DateTime.now().toIso8601String().substring(0, 10);

  /// Si pasó más de 1 día sin estudiar, la racha se pierde.
  void _revisarRacha() {
    final ultima = _p.getString('ultima');
    if (ultima == null) return;
    final dias = DateTime.parse(_hoy).difference(DateTime.parse(ultima)).inDays;
    if (dias > 1) {
      racha = 0;
      _p.setInt('racha', 0);
    }
  }

  /// Llámalo cuando el usuario estudie algo (quiz, ejercicio, etc.).
  Future<void> registrarEstudio() async {
    if (_p.getString('ultima') == _hoy) return; // ya contó hoy
    racha += 1;
    await _p.setInt('racha', racha);
    await _p.setString('ultima', _hoy);
    notifyListeners();
  }

  // ── Quizzes ──
  int mejor(String id) => _p.getInt('mejor_$id') ?? 0;
  bool aprobada(String id) => mejor(id) >= 70;

  Future<void> guardarQuiz(String id, int porcentaje) async {
    if (porcentaje > mejor(id)) await _p.setInt('mejor_$id', porcentaje);
    await registrarEstudio();
    notifyListeners();
  }

  // ── Ejercicios de la hoja (casillas hechas / no hechas) ──
  bool ejercicioHecho(String id, String num) =>
      _p.getBool('ej_${id}_$num') ?? false;

  Future<void> marcarEjercicio(String id, String num, bool v) async {
    await _p.setBool('ej_${id}_$num', v);
    if (v) await registrarEstudio();
    notifyListeners();
  }

  // ── Textos que escribe el estudiante (proceso y resultado) ──
  String texto(String clave) => _p.getString(clave) ?? '';
  Future<void> guardarTexto(String clave, String valor) =>
      _p.setString(clave, valor);

  /// Progreso total 0.0 a 1.0, ponderado con los puntos de la rúbrica
  /// (la Evaluación final pesa 2.0, o sea la mitad del "Saber").
  double get progresoTotal {
    double suma = 0, pesos = 0;
    for (final a in unidad1) {
      suma += a.peso * mejor(a.id) / 100;
      pesos += a.peso;
    }
    return suma / pesos;
  }
}

final progress = ProgressService(); // instancia global simple
