import 'package:flutter/material.dart';
import '../repository/repository_ejemplo.dart';
import 'infocomarca_screen.dart';

// Aceptamos un nombre de provincia para mostrar en la AppBar (si se quiere)
class ComarcasScreen extends StatelessWidget {
  final String? provinceName;
  const ComarcasScreen({
    super.key,
    this.provinceName,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(provinceName != null ? 'Comarcas - ${provinceName!}' : 'Comarcas'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: RepositoryEjemplo.obtenerComarcas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final comarcas = snapshot.data ?? [];

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: comarcas.length,
            itemBuilder: (context, index) {
              final comarca = comarcas[index];
              final id = comarca['id']?.toString() ?? '';
              final nombre = comarca['nombre']?.toString() ?? 'Sin nombre';
              final img = comarca['imagen']?.toString();

              return GestureDetector(
                onTap: () {
                  if (id.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoComarcaScreen(comarcaId: id),
                      ),
                    );
                  }
                },
                child: ComarcaCard(
                  comarca: nombre,
                  img: img,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ComarcaCard extends StatelessWidget {
  final String comarca;
  final String? img;

  const ComarcaCard({
    super.key,
    required this.comarca,
    this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: img?.isNotEmpty == true
                ? buildImage(img!)
                : fallbackImage(),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).primaryColor.withAlpha((0.1 * 255).round()), // Cambiado withOpacity por withAlpha
            child: Text(
              comarca,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (_, __, ___) => fallbackImage(),
      );
    }

    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallbackImage(),
      );
    }

    // Fallback a Network para rutas no reconocidas
    return Image.network(
      path,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (_, __, ___) => fallbackImage(),
    );
  }

  Widget fallbackImage() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.landscape,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }
}
