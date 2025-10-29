import '../models/provincia.dart';
import '../models/comarca.dart';

/*
Esta clase nos proporciona información estática de ejemplo sobre las provincias y comarcas.

 */
class RepositoryEjemplo {
  // Datos de ejemplo para las provincias
  static final List<Map<String, dynamic>> _provincias = [
    {
      'nombre': 'Alicante',
      'imagen': 'https://example.com/alicante.jpg'
    },
    {
      'nombre': 'Valencia',
      'imagen': 'https://example.com/valencia.jpg'
    },
    {
      'nombre': 'Castellón',
      'imagen': 'https://example.com/castellon.jpg'
    }
  ];

  static List<Provincia> obtenerProvincias() {
    return _provincias.map((provincia) => Provincia.fromJSON(provincia)).toList();
  }    


  static List<Map<String, dynamic>> _comarcasData = [
    {
      'id': 'marina_alta',
      'comarca': 'Marina Alta',
      'capital': 'Dénia',
      'poblacion': 169327,
      'img': 'assets/img/marina_alta.jpg',
      'desc': 'La Marina Alta es una comarca...',
      'latitud': 38.8417,
      'longitud': 0.1057
    },
    // Añade más comarcas aquí si es necesario
  ];

  static Future<List<dynamic>> obtenerComarcas() async {
    // Simulamos una carga asíncrona
    await Future.delayed(const Duration(milliseconds: 500));
    return _comarcasData;
  }

  static Comarca obtenerInfoComarca(String id) {
    final comarcaData = _comarcasData.firstWhere(
      (comarca) => comarca['id'] == id,
      orElse: () => _comarcasData.first,
    );
    return Comarca.fromJSON(comarcaData);
  }
}