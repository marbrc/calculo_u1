import 'package:eco_ruta/models/residuo.dart';
import 'package:eco_ruta/services/reciclaje_service.dart';
import 'package:eco_ruta/widgets/residuo_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final service = ReciclajeService();
  final residuos = [
    Residuo(nombre: 'Caja de carton', tipo: 'papel'),
    Residuo(nombre: 'Cascara de platano', tipo: 'organico'),
    Residuo(nombre: 'Botella de PET', tipo: 'plastico'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EcoRuta')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Toca el residuo para saber donde colocarlo'),
          const SizedBox(height: 12),
          for (final residuo in residuos)
            ResiduoCard(
              residuo: residuo,
              onTap: () {
                final respuesta = service.contenedorPara(residuo.tipo);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(respuesta)),
                );
              },
            ),
        ],
      ),
    );
  }
}