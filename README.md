## Desarrollo Móvil – Solemne 01

Este proyecto corresponde a la evaluación práctica de la Solemne 01, donde se desarrolla una aplicación móvil en Flutter para el registro, gestión de usuarios y configuración de preferencias.

El proyecto está desarrollado en equipo y organizado por módulos para facilitar el trabajo colaborativo.

## Estructura del Proyecto

La aplicación está organizada de la siguiente manera:

lib/
 ├── main.dart
 ├── models/
 │     └── user.dart
 ├── data/
 │     └── users_data.dart
 ├── screens/
 │     ├── user_list_screen.dart
 │     ├── user_form_screen.dart
 │     ├── profile_screen.dart
 │     └── settings_screen.dart
 ├── widgets/
 │     └── user_card.dart
 
## Descripción de carpetas
Carpeta	Función
models	Modelos de datos (ej: Usuario)
data	Datos estáticos (lista de usuarios)
screens	Pantallas de la aplicación
widgets	Componentes reutilizables
main.dart	Punto de entrada y navegación
Funcionalidades de la App
Enunciado 1 – Registro y Gestión de Usuarios
Lista de usuarios
Mostrar nombre, correo y avatar
Formulario para crear/editar usuario
Validaciones:
Nombre obligatorio (≥ 3 caracteres)
Correo válido
Teléfono ≥ 8 dígitos
Edad entre 18 y 100
Descripción ≥ 10 caracteres
Navegación entre pantallas
Enunciado 2 – Perfil y Configuración
Pantalla de perfil
Pantalla de configuración
Preferencias:
Tema (claro / oscuro / sistema)
Color principal
Notificaciones (Switch)
Tipos de notificación (Checkbox)
Intereses
Widgets Utilizados
MaterialApp
Scaffold
AppBar
ListView
Card
TextField / TextFormField
Form
ElevatedButton
OutlinedButton
TextButton
Switch
Checkbox
Radio
DropdownButton
Navigator
Navegación

La aplicación utiliza rutas nombradas:

Ruta	Pantalla
/	Lista de usuarios
/form	Formulario
/profile	Perfil
/settings	Configuración

## Instalación y Uso
Cómo ejecutar el proyecto

1. **Clonar el repositorio**
```bash
git clone [https://github.com/constanzacauchupan/Solemne-desarrollo-movil.git]
cd prueba
git checkout 
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar aplicacion**
```bash
flutter run
```

## Organización del Equipo
Integrante	Responsabilidad
Integrante 1	Lista de usuarios
Integrante 2	Formulario
Integrante 3	Validaciones
Integrante 4	Navegación
Integrante 5	Pantalla Perfil
Integrante 6	Pantalla Configuración
Diseño UI

La aplicación utiliza:

Material Design 3
ColorScheme.fromSeed
Widgets accesibles
Iconos en los campos
Diseño responsive con Scroll
Notas Importantes
La aplicación utiliza datos estáticos (no base de datos).
El formulario funciona en modo creación y edición.
Se utiliza Navigator para el cambio de pantallas.
Se implementan validaciones en todos los campos.
