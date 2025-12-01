class Comarca {
  late String comarca;
  String? capital;
  int? poblacion;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;

  Comarca.fromJSON(Map<String, dynamic> objecteJSON) {
    comarca = objecteJSON["comarca"] ?? "";
    capital = objecteJSON["capital"] ?? "";
    
    // Corrección: verificar si poblacio existe y no es null
    if (objecteJSON["poblacio"] != null) {
      poblacion = int.parse(objecteJSON["poblacio"].toString().replaceAll(".", ""));
    } else if (objecteJSON["poblacion"] != null) {
      // También verificar si viene como "poblacion" en lugar de "poblacio"
      poblacion = objecteJSON["poblacion"] is int 
          ? objecteJSON["poblacion"]
          : int.parse(objecteJSON["poblacion"].toString().replaceAll(".", ""));
    } else {
      poblacion = 0;
    }
    
    img = objecteJSON["img"] ?? "";
    desc = objecteJSON["desc"] ?? "";    
    latitud = objecteJSON["latitud"] is double ? objecteJSON["latitud"] : (objecteJSON["latitud"]?.toDouble() ?? 0.0);
    longitud = objecteJSON["longitud"] is double ? objecteJSON["longitud"] : (objecteJSON["longitud"]?.toDouble() ?? 0.0);
  }

  @override
  String toString() {
    return '''\x1B[34mComarca:\t\x1B[36m$comarca\n\x1B[0m
\x1B[34mcapital:\t\x1B[36m$capital\n\x1B[0m
\x1B[34mpoblacio:\t\x1B[36m${poblacion.toString()}\n\x1B[0m
\x1B[34mImatge:\t\t\x1B[36m$img\n\x1B[0m
\x1B[34mdescripció:\t\x1B[36m$desc\n\x1B[0m
\x1B[34mCoordenades:\t\x1B[36m($latitud, $longitud)\x1B[0m''';
  }
}
