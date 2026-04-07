final List<Map<String, dynamic>> usuariosSolemne = List.generate(50, (index) {
  int n = index + 1;
  return {
    "nombre": "Estudiante $n",
    "correo": "estudiante$n@correo.cl",
    "telefono": "9876543${(index % 10).toString().padLeft(2, '0')}",
    "edad": 18 + (index % 10),
    "descripcion": "Soy el estudiante número $n y esta es mi descripción.",
  };
});