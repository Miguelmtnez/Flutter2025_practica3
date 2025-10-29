class Comarca {
  // Añadimos late para indicar que se inicializará
  // después. También podríamos añadir un valor por defecto
  late String comarca;
  String? capital;
  int? poblacion;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;

  // Constructor con argumentos por nombre,
  // obligatorios i opcionales

  Comarca(
      {required this.comarca,
      this.capital,
      this.poblacion,
      this.img,
      this.desc,
      this.latitud,
      this.longitud});

  // Inicialización con diccionario
  Comarca.fromJSON(Map<String, dynamic> objecteJSON) {
    comarca = objecteJSON["comarca"] ?? "";
    capital = objecteJSON["capital"] ?? "";
    poblacion = int.parse(objecteJSON["poblacio"].replaceAll(".",""));
    img = objecteJSON["img"] ?? "";
    desc = objecteJSON["desc"] ?? "";    
    latitud = objecteJSON["latitud"] ?? 0.0;
    longitud = objecteJSON["longitud"] ?? 0.0;
  }

  @override
  String toString() {
    return '''\x1B[34mnom:\t\t\x1B[36m$comarca\n\x1B[0m
\x1B[34mcapital:\t\x1B[36m$capital\n\x1B[0m
\x1B[34mpoblacio:\t\x1B[36m${poblacion.toString()}\n\x1B[0m
\x1B[34mImatge:\t\t\x1B[36m$img\n\x1B[0m
\x1B[34mdescripció:\t\x1B[36m$desc\n\x1B[0m
\x1B[34mCoordenades:\t\x1B[36m($latitud, $longitud)\x1B[0m''';
  }
}
