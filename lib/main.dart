import 'package:flutter/material.dart';
import 'data/users_data.dart';
import 'screens/registration_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solemne 01',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Usuarios"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: usuariosSolemne.length,
        itemBuilder: (context, index) {
          final usuario = usuariosSolemne[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.person),
            ),
            title: Text(usuario["nombre"]),
            subtitle: Text(usuario["correo"]),
            // Tap corto → ver Perfil
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(usuario: usuario),
                ),
              );
            },
            // Tap largo → Editar datos básicos (comportamiento original)
            onLongPress: () async {
              final usuarioEditado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      RegistrationScreen(usuarioExistente: usuario),
                ),
              );
              if (usuarioEditado != null) {
                setState(() {
                  usuariosSolemne[index] = usuarioEditado;
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoUsuario = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const RegistrationScreen()),
          );
          if (nuevoUsuario != null) {
            setState(() {
              usuariosSolemne.add(nuevoUsuario);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}