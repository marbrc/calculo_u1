import 'package:design_patters/singleton.dart';

import 'package:test/test.dart';

void main(){

  // Reiniciar antes de cada test

  setUp((){});

  Nave.instancia.combustible = 100;

  Nave.instancia.nombre = 'El Halcon Milenario';


  test('Solo debe de existir una nave',(){

    final nave1 = Nave.instancia;

    final nave2 = Nave.instancia;

    expect(identical(nave1, nave2), true);

  });

  test('El estado se comparte', (){

    Nave.instancia.nombre = 'X-Win';

    expect(Nave.instancia.nombre, 'X-Win');

  });

  test('Despegar consume combustible',(){

    Nave.instancia.despegar();

    Nave.instancia.despegar();
    Nave.instancia.despegar();
    Nave.instancia.despegar();
    Nave.instancia.despegar();

    expect(Nave.instancia.combustible, 80);
  


  });

  test('No despega sin combustible tonte', (){
    Nave.instancia.combustible = 10;
    Nave.instancia.despegar();
    expect(Nave.instancia.combustible, 10);

  });

  test('Cargar... restaura el combustible',(){
    Nave.instancia.combustible =20;
    Nave.instancia.cargar();

    expect(Nave.instancia.combustible, 100);
  });

}