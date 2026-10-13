/// Pregunta de opción múltiple (para los quizzes).
class Pregunta {
  final String texto;
  final List<String> opciones;
  final int correcta; // índice de la opción correcta
  final String explicacion;
  const Pregunta(this.texto, this.opciones, this.correcta, this.explicacion);
}

/// Ejercicio de la hoja (el que se resuelve en la libreta).
class Ejercicio {
  final String numero;
  final String indicacion; // lo que pide el ejercicio
  final String enunciado; // la función / expresión
  const Ejercicio(this.numero, this.indicacion, this.enunciado);
}

/// Una lección: título + bloques de texto (cada bloque es un párrafo).
/// Los bloques que empiezan con "EJEMPLO:" se pintan resaltados.
class Leccion {
  final String titulo;
  final List<String> bloques;
  final String? videoUrl; // link del video (YouTube, etc.). null = "próximamente"
  const Leccion(this.titulo, this.bloques, [this.videoUrl]);
}

/// Ayuda y solución de un ejercicio (se busca con la clave "idActividad-numero").
class Solucion {
  final List<String> pistas; // de la más suave a la más clara
  final List<String> pasos; // solución paso a paso (se muestra al revisar)
  final String resultado; // resultado final
  final List<String> aceptadas; // respuestas que la app puede validar sola
  const Solucion(this.pistas, this.pasos, this.resultado,
      [this.aceptadas = const []]);
}

/// Actividad 1, 2, 3 o la Evaluación final.
class Actividad {
  final String id;
  final String titulo;
  final String descripcion;
  final String emoji;
  final double peso; // puntos "Saber" de la rúbrica (0.5, 0.5, 1.0, 2.0)
  final List<Leccion> lecciones;
  final List<Ejercicio> ejercicios;
  final List<Pregunta> quiz;
  const Actividad(this.id, this.titulo, this.descripcion, this.emoji, this.peso,
      this.lecciones, this.ejercicios, this.quiz);
}
