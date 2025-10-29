import 'package:flutter/material.dart';
import '../models/comarca.dart';
import 'infocomarca_detall.dart';

class InfoComarcaGeneral extends StatelessWidget {
  final Comarca comarca;

  const InfoComarcaGeneral({
    super.key,
    required this.comarca,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comarca.comarca),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen de la comarca
            if (comarca.img?.isNotEmpty == true)
              Image.network(
                comarca.img!,
                height: 200,
                fit: BoxFit.cover,
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información básica
                  Text(
                    'Capital: ${comarca.capital ?? "No disponible"}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Población: ${comarca.poblacion ?? "No disponible"} habitantes',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),

                  // Descripción
                  Text(
                    comarca.desc ?? 'Sin descripción disponible',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // Botón para ver más detalles
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoComarcaDetall(
                              comarcaId: comarca.comarca,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Ver más detalles'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
