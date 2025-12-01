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


  static final List<Map<String, dynamic>> _comarcasData = [
    {
      'id': 'marina_alta',
      'nombre': 'Marina Alta',
      'imagen': 'assets/img/marina_alta.jpg',
      'comarca': 'Marina Alta',
      'capital': 'Dénia',
      'poblacion': 169327,
      'img': 'assets/img/marina_alta.jpg',
      'desc': 'La Marina Alta es una comarca situada al norte de la provincia de Alicante, caracterizada por sus playas mediterráneas y montañas.',
      'latitud': 38.8417,
      'longitud': 0.1057
    },
    {
      'id': 'alacanti',
      'nombre': 'Alacantí',
      'imagen': 'assets/img/alacanti.jpg',
      'comarca': 'Alacantí',
      'capital': 'Alicante',
      'poblacion': 478417,
      'img': 'assets/img/alacanti.jpg',
      'desc': 'El Alacantí es una comarca de la provincia de Alicante que incluye la ciudad de Alicante y municipios cercanos.',
      'latitud': 38.3452,
      'longitud': -0.4815
    },
    {
      'id': 'vega_baja',
      'nombre': 'Vega Baja',
      'imagen': 'assets/img/vega_baja.jpg',
      'comarca': 'Vega Baja del Segura',
      'capital': 'Orihuela',
      'poblacion': 403175,
      'img': 'assets/img/vega_baja.jpg',
      'desc': 'La Vega Baja del Segura es una comarca situada en el sur de Alicante, conocida por su agricultura de regadío.',
      'latitud': 38.0858,
      'longitud': -0.9431
    },
    {
      'id': 'marina_baixa',
      'nombre': 'Marina Baixa',
      'imagen': 'assets/img/marina_baixa.jpg',
      'comarca': 'Marina Baixa',
      'capital': 'Villajoyosa',
      'poblacion': 192854,
      'img': 'assets/img/marina_baixa.jpg',
      'desc': 'La Marina Baixa es una comarca costera de Alicante conocida por sus destinos turísticos como Benidorm.',
      'latitud': 38.5706,
      'longitud': -0.1531
    },
    {
      'id': 'alcoià',
      'nombre': 'L\'Alcoià',
      'imagen': 'assets/img/alcoia.jpg',
      'comarca': 'L\'Alcoià',
      'capital': 'Alcoy',
      'poblacion': 75824,
      'img': 'assets/img/alcoia.jpg',
      'desc': 'L\'Alcoià es una comarca interior de Alicante con tradición industrial y rica historia.',
      'latitud': 38.7042,
      'longitud': -0.4750
    },
    {
      'id': 'baix_vinalopo',
      'nombre': 'Baix Vinalopó',
      'imagen': 'assets/img/baix_vinalopo.jpg',
      'comarca': 'Baix Vinalopó',
      'capital': 'Elche',
      'poblacion': 302516,
      'img': 'assets/img/baix_vinalopo.jpg',
      'desc': 'El Baix Vinalopó es una comarca de Alicante conocida por su producción agrícola, especialmente el palmeral de Elche.',
      'latitud': 38.2669,
      'longitud': -0.6983
    }
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