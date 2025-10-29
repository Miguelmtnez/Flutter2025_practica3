import 'package:flutter/material.dart';
import '../repository/repository_ejemplo.dart';

class ComarcasScreen extends StatelessWidget {
  const ComarcasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comarcas'),
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
              return ComarcaCard(
                comarca: comarca['nombre'],
                img: comarca['imagen'],
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
                ? Image.network(
                    img!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _fallbackImage(),
                  )
                : _fallbackImage(),
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

  Widget _fallbackImage() {
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
