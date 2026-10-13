class Nave {
  // 1. Constructor privado = nombre de la clase el ._ significa privado
  Nave._internal();

  // 2. Instancia unica. ? es para ponerlo sin iniciar, lo declara son iniciar
  static Nave? _instancia;

  // 3. Punto de acceso
  static Nave get instancia{
    _instancia ??= Nave._internal(); // ??= si esta nulo realiza lo q viene allá SOLO SI ES NULL

    return _instancia!;
  }

  // 4. Estado de la instancia
  String nombre ='El Halcon';
  int combustible = 100;

  // 5. Métodos de la instancia
  void despegar(){
    if(combustible>=20){
      combustible -= 20;
      print('$nombre despegó!🚀  Combustible: $combustible');
    }else{
      print('Sin combustible suficiente');
    }
  }

  void cargar(){
    combustible = 100;
    print('El combustible fue cargado tonte');

  }


}