import 'package:flutter/material.dart';

// Importa tus pantallas
import 'screens/user_list_screen.dart';
import 'screens/user_form_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Tema (IMPORTANTE para la nota)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // Pantalla inicial
      initialRoute: '/',

      // Rutas
      routes: {
        '/': (context) => const UserListScreen(),
        '/form': (context) => const UserFormScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}