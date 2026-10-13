import 'package:flutter/material.dart';
import 'services/progress_service.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await progress.cargar(); // Carga racha y calificaciones guardadas
  runApp(const CalculoApp());
}

class CalculoApp extends StatelessWidget {
  const CalculoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo U1',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,
      home: const HomeScreen(),
    );
  }
}
