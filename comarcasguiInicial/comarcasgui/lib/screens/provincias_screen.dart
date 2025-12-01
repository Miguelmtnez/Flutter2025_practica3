import 'package:flutter/material.dart';
import '../repository/repository_ejemplo.dart';
import '../models/provincia.dart';
import 'comarcas_screen.dart';

class ProvinciaRoundButton extends StatelessWidget {
  final Provincia provincia;

  const ProvinciaRoundButton({
    super.key,
    required this.provincia,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: provincia.imagen.isNotEmpty
              ? NetworkImage(provincia.imagen)
              : null,
          backgroundColor: Colors.grey.shade200,
          child: provincia.imagen.isEmpty
              ? const Icon(Icons.location_city, size: 40)
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          provincia.nombre,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ProvinciasScreen extends StatelessWidget {
  const ProvinciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provincias = RepositoryEjemplo.obtenerProvincias();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provincias'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: provincias
              .map(
                (provincia) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComarcasScreen(
                          provinceName: provincia.nombre,
                        ),
                      ),
                    );
                  },
                  child: ProvinciaRoundButton(provincia: provincia),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
