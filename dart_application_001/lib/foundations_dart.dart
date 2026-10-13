// Dart es un lenguaje de tipado fuerte pero con la inferencia de tipos

//Tipos básicos

// 1. Números
int edad = 19; // TIPO ENTERO
double altura = 1.82; // Decimales
num cualquierNumero = 3.14; // puede ser entero o decimal, no impota 

// 2. Cadenas de texto
String nombre = "Mar Barcenas";
String mensaje = "holissss a todes";
String otroMensaje = 'si funka con comillas simples'; // con comillas simples si funcionaaa

// primitivos = enteros, numeros, caracteres, boleanos
// no primitivos = cadenas. 

String multilinea = """Este es 
un texto de varias
lineas""";// cadena de caracteres multilinea

// 3. Boleanos
bool esEstudiante = true;
bool tieneExperiencia = false;

// 4. Listas
List<String> frutas = ["Manzana", "Platano", "Fresa", "Mango"];
var numeros = [1,2,3,4,5,6];

// 5. Diciionarios o Mapas
Map<String, dynamic> usuario = {
  'Nombre': ' Mar',
  'Edad': 19,
  'Ciudad':'San Miguel de Allende'
}; // los mapas si van con llaves


// 6. Dinamicos (cualquier tipo)
dynamic valor = 'Holiss';
//valor = 123;

// 7. Funciones

// Función simple
void saludar(String nombre){
  print("Holis ${nombre}");
}

// Función con retorno
int sumar(int a, int b){
  return a + b;
}

// Función en una linea
int multiplicar (int a, int b)=> a * b;

// Control de flujo
// 1. Condicionales if/else
void evaluarEdad(int edad){
  if (edad >= 18){
    print('Eres mayor de edad');
  }else if(edad >= 13){
    print('Eres un adolescente');
  }else{
    print('Eres un niñe');
  }
}

// 2. Switch
void diaSemana(int numero){
  switch (numero) {
    case 1:
      print('Lunes');
      break;
    case 2:
      print('Martes');
      break;
    default:
      print('Otro día');
    
  }
}

// 3. Ciclos o bucles
void buclesEjemplo(){
  //For
  for(int i = 0; i<5; i++){
    print('Iteracnion: $i');
  }
  // for-in (para listas)
  List<String> nombres = ['Ana', 'Luis', 'Carlos'];
  for(String nombre in nombres){
    print('Holissss $nombre');
  }
  //ciclo while
  int contador = 0;
  while (contador < 3) {
    print('Contador: $contador');
    contador ++; //eso hace que se termine el ciclo despues de 3 iteraciones
    
  }
}

// 4. Operador ternario
int edad1 = 10;
String mensaje1 = edad1 >= 18 ? 'Mayor de edad' : 'Menor de Edad';


/** Crear función que reciba un numero
* y que desde el cero hasta ese numero 
* me ponga los numeros multiplos de 3
*/


void recibenum(int num1){
  for (int i = 0; i<=num1; i++){
    if (i % 3 ==0){
      print(i);
    }
  }

}






