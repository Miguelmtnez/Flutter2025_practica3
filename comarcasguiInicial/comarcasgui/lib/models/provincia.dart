class Provincia {
  final String nombre;
  final String imagen;  // Añadido el campo imagen

  Provincia({
    required this.nombre,
    required this.imagen,
  });

  // Constructor fromJSON
  factory Provincia.fromJSON(Map<String, dynamic> json) {
    return Provincia(
      nombre: json['nombre'] ?? '',
      imagen: json['imagen'] ?? '',
    );
  }
}