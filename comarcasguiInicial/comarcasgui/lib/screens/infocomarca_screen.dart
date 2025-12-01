import 'package:flutter/material.dart';
import '../models/comarca.dart';
import '../repository/repository_ejemplo.dart';
import 'widgets/my_weather_info.dart';

/// Pantalla con NavigationBar que muestra Info General e Info Detallada de una comarca
class InfoComarcaScreen extends StatefulWidget {
  final String comarcaId;

  const InfoComarcaScreen({
    super.key,
    required this.comarcaId,
  });

  @override
  State<InfoComarcaScreen> createState() => _InfoComarcaScreenState();
}

class _InfoComarcaScreenState extends State<InfoComarcaScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Comarca comarca = RepositoryEjemplo.obtenerInfoComarca(widget.comarcaId);

    return Scaffold(
      appBar: AppBar(
        title: Text(comarca.comarca),
      ),
      body: _selectedIndex == 0
          ? _buildInfoGeneral(comarca)
          : _buildInfoDetallada(comarca),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Info General',
          ),
          NavigationDestination(
            icon: Icon(Icons.details_outlined),
            selectedIcon: Icon(Icons.details),
            label: 'Info Detallada',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGeneral(Comarca comarca) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen de la comarca
          if (comarca.img?.isNotEmpty == true)
            _buildImage(comarca.img!),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  comarca.comarca,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Información básica
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          context,
                          Icons.location_city,
                          'Capital',
                          comarca.capital ?? 'No disponible',
                        ),
                        const Divider(height: 24),
                        _buildInfoRow(
                          context,
                          Icons.people,
                          'Población',
                          '${comarca.poblacion ?? "N/A"} habitantes',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Descripción
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Descripción',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          comarca.desc ?? 'Sin descripción disponible',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoDetallada(Comarca comarca) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget del tiempo
          const MyWeatherInfo(),
          const SizedBox(height: 16),

          // Información detallada
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalles',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Población
                  _buildInfoRow(
                    context,
                    Icons.people,
                    'Población',
                    '${comarca.poblacion ?? "N/A"} habitantes',
                  ),
                  const SizedBox(height: 16),

                  // Coordenadas
                  _buildInfoRow(
                    context,
                    Icons.location_on,
                    'Latitud',
                    comarca.latitud?.toString() ?? 'N/A',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    context,
                    Icons.location_on,
                    'Longitud',
                    comarca.longitud?.toString() ?? 'N/A',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 250,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 250,
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    } else if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 250,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
            ),
          );
        },
      );
    } else {
      // Por defecto, intentar cargar como network
      return Image.network(
        path,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 250,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
            ),
          );
        },
      );
    }
  }
}
