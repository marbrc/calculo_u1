import 'package:flutter/material.dart';
import 'package:mercado_local/producto.dart';

void main() => runApp(const MercadoApp());

class MercadoApp extends StatelessWidget {
  const MercadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: const MercadoPage());
  }
}

class MercadoPage extends StatefulWidget {
  const MercadoPage({super.key});

  @override
  State<StatefulWidget> createState() => _MercadoPageState();
}

class _MercadoPageState extends State<MercadoPage> {
  final productos = const [
    Producto(nombre: 'Maiz', precio: 12, productor: 'Productor local', categoria: 'Granos'),
    Producto(nombre: 'Jitomate', precio: 25, productor: 'Huerto comunitario', categoria: 'Frutas'),
    Producto(nombre: 'Frijol', precio: 38, productor: 'Cooperativa regional', categoria: 'Granos'),
    Producto(nombre: 'Chile', precio: 30,productor: 'Agricultor independiente', categoria: 'Verduras'),
  ];

  String nombreBusca = "";
  String categoriaBusca = "Todos";

  @override
  Widget build(BuildContext context) {
    final visibles = productos
        .where((p) {
          final nombre = p.nombre.toLowerCase();
          final categoria = p.categoria.toLowerCase();
          final coincideNombre = nombre.contains(nombreBusca.toLowerCase());
          final coincideCategoria = categoriaBusca == 'Todos' || categoria == categoriaBusca.toLowerCase();
          return coincideCategoria && coincideNombre;
        }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Mercado local')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar Producto',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) => setState(() => nombreBusca = valor),
            ),
            const SizedBox(height: 16),
            DropdownButton(
              value: categoriaBusca,
              isExpanded: true,
              items: [
                'Todos',
                'Granos',
                'Frutas',
                'Verduras'
              ].map((opcion){
                return DropdownMenuItem(
                  value: opcion,
                  child: Text(opcion));
              }).toList(), 
              onChanged: (valor){
                setState(() {
                  categoriaBusca = valor!;   
                });
              }
              ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: visibles.length,
                itemBuilder: (context, index) {
                  final p = visibles[index];
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.eco)),
                      title: Text(p.nombre),
                      subtitle: Text(p.productor),
                      trailing: Text('\$ ${p.precio.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Proximamente: registrar producto'),
      ),
    );
  },
  child: const Icon(Icons.add),
),
    );
  }
}
