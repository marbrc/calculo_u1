import 'package:dart_application_001/dart_application_001.dart' as dart_application_001;
import 'package:dart_application_001/foundations_dart.dart' as found;

void main(List<String> arguments) {
  print('Hello world: ${dart_application_001.calculate()}!');
  print (found.frutas);
  print (found.nombre);
  print('${found.edad}, ${found.nombre}, ${found.multilinea}');
  print(found.usuario);

  found.saludar("Maria Barcenas");
  print(found.sumar(15, 30));
  print(found.multiplicar(60, 70));
  found.evaluarEdad(20);
  found.evaluarEdad(15);
  found.evaluarEdad(10);
  found.diaSemana(1);
  found.diaSemana(2);
  found.diaSemana(2468);
  found.buclesEjemplo();
  print(found.mensaje1);
  print(found.recibenum(15));




}

