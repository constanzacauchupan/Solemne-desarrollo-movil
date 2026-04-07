import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final Map<String, dynamic>? usuarioExistente;

  const RegistrationScreen({super.key, this.usuarioExistente});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _edadController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.usuarioExistente != null) {
      _nombreController.text = widget.usuarioExistente!["nombre"] ?? "";
      _correoController.text = widget.usuarioExistente!["correo"] ?? "";
      _telefonoController.text = widget.usuarioExistente!["telefono"]?.toString() ?? "";
      _edadController.text = widget.usuarioExistente!["edad"]?.toString() ?? "";
      _descripcionController.text = widget.usuarioExistente!["descripcion"] ?? "";
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _edadController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool esEdicion = widget.usuarioExistente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? "Editar/Ver Usuario" : "Registrar Usuario"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.length < 3) return 'Mínimo 3 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || !value.contains('@') || !value.contains('.')) {
                    return 'Correo inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null) return 'Obligatorio';
                  final phone = value.replaceAll(' ', '').replaceAll('-', '');
                  if (phone.length < 8) return 'Mínimo 8 dígitos';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) return 'Obligatorio';
                  final edad = int.tryParse(value);
                  if (edad == null || edad < 18 || edad > 100) {
                    return 'Entre 18 y 100 años';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.length < 10) return 'Mínimo 10 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final usuarioGuardado = {
                      "nombre": _nombreController.text,
                      "correo": _correoController.text,
                      "telefono": _telefonoController.text,
                      "edad": int.parse(_edadController.text),
                      "descripcion": _descripcionController.text,
                    };
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(esEdicion ? 'Usuario actualizado' : 'Usuario registrado')),
                    );
                    
                    Navigator.pop(context, usuarioGuardado);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}