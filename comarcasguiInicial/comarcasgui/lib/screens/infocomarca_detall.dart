import 'package:comarcasgui/models/comarca.dart';
import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:flutter/material.dart';
import 'package:comarcasgui/screens/widgets/my_weather_info.dart';

class InfoComarcaDetall extends StatelessWidget {
  final String comarcaId;

  const InfoComarcaDetall({
    super.key,
    required this.comarcaId,
  });

  @override
  Widget build(BuildContext context) {
    Comarca comarca = RepositoryEjemplo.obtenerInfoComarca(comarcaId);

    return Scaffold(
      appBar: AppBar(
        title: Text(comarca.comarca),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget del tiempo
            const MyWeatherInfo(),
            const Divider(height: 32),

            // Información detallada
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Población
                    _buildInfoRow(
                      context,
                      'Población:',
                      '${comarca.poblacion ?? "N/A"} habitantes',
                      Icons.people,
                    ),
                    const SizedBox(height: 16),

                    // Coordenadas
                    _buildInfoRow(
                      context,
                      'Latitud:',
                      comarca.latitud?.toString() ?? 'N/A',
                      Icons.location_on,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      context,
                      'Longitud:',
                      comarca.longitud?.toString() ?? 'N/A',
                      Icons.location_on,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
