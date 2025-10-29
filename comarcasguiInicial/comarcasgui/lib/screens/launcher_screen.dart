import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:comarcasgui/screens/comarcas_screen.dart';
import 'package:comarcasgui/screens/infocomarca_detall.dart';
import 'package:comarcasgui/screens/infocomarca_general.dart';
import 'package:comarcasgui/screens/provincias_screen.dart';
import 'package:flutter/material.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProvinciasScreen()),
                );
              },
              child: const Text("Pantalla Provincias")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ComarcasScreen()),
                );
              },
              child: const Text("Pantalla Comarcas")),
          ElevatedButton(
              onPressed: () async {
                // Obtenemos la primera comarca de la lista como ejemplo
                final comarcas = await RepositoryEjemplo.obtenerComarcas();
                if (context.mounted && comarcas.isNotEmpty) {
                  final comarca = RepositoryEjemplo.obtenerInfoComarca(comarcas[0]['id']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoComarcaGeneral(comarca: comarca),
                    ),
                  );
                }
              },
              child: const Text("Pantalla con información \n general de la comarca")),
          ElevatedButton(
              onPressed: () async {
                // Obtenemos el ID de la primera comarca como ejemplo
                final comarcas = await RepositoryEjemplo.obtenerComarcas();
                if (context.mounted && comarcas.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoComarcaDetall(
                        comarcaId: comarcas[0]['id'],
                      ),
                    ),
                  );
                }
              },
              child: const Text("Pantalla con información \n detallada de la comarca"))
        ],
      ),
    );
  }
}
