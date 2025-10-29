import 'package:flutter/material.dart';

class MyWeatherInfo extends StatelessWidget {
  const MyWeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        _obtenerIconoTiempo("0"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.thermostat,
              size: 35,
            ),
            Text(
              "5º",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wind_power, size: 35),
            const SizedBox(width: 30),
            Text(
              "20 km/h",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(width: 30),
            obtenerWidgetDireccionViento("0.0", context),
          ],
        ),
      ],
    );
  }

  Widget obtenerWidgetDireccionViento(String direccionViento, BuildContext context) {
    double dir = double.parse(direccionViento);
    late Icon icono;

    late String nombreViento;

    if (dir > 22.5 && dir < 65.5) {
      icono = const Icon(Icons.north_east);
      nombreViento = "Gregal";
    } else if (dir > 67.5 && dir < 112.5) {
      icono = const Icon(Icons.east);
      nombreViento = "Llevant";
    } else if (dir > 112.5 && dir < 157.5) {
      icono = const Icon(Icons.south_east);
      nombreViento = "Xaloc";
    } else if (dir > 157.5 && dir < 202.5) {
      icono = const Icon(Icons.south);
      nombreViento = "Migjorn";
    } else if (dir > 202.5 && dir < 247.5) {
      icono = const Icon(Icons.south_west);
      nombreViento = "Llebeig/Garbí";
    } else if (dir > 247.5 && dir < 292.5) {
      icono = const Icon(Icons.west);
      nombreViento = "Ponent";
    } else if (dir > 292.5 && dir < 337.5) {
      icono = const Icon(Icons.north_west);
      nombreViento = "Mestral";
    } else {
      icono = const Icon(Icons.north);
      nombreViento = "Tramuntana";
    }
    return Row(children: [
      Text(
        nombreViento,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      icono,
    ]);
  }

  // Codigos de https://open-meteo.com/en/docs/dwd-api

  Widget _obtenerIconoTiempo(String value) {
    Set<String> sol = <String>{"0"};
    Set<String> pocasNubes = <String>{"1", "2", "3"};
    Set<String> nubes = <String>{"45", "48"};
    Set<String> lluviaSuave = <String>{"51", "53", "55"};
    Set<String> lluvia = <String>{
      "61",
      "63",
      "65",
      "66",
      "67",
      "80",
      "81",
      "82",
      "95",
      "96",
      "99"
    };
    Set<String> neu = <String>{"71", "73", "75", "77", "85", "86"};

    if (sol.contains(value)) {
      return Image.asset("assets/icons/png/soleado.png");
    }
    if (pocasNubes.contains(value)) {
      return Image.asset("assets/icons/png/poco_nublado.png");
    }
    if (nubes.contains(value)) {
      return Image.asset("assets/icons/png/nublado.png");
    }
    if (lluviaSuave.contains(value)) {
      return Image.asset("assets/icons/png/lluvia_debil.png");
    }
    if (lluvia.contains(value)) {
      return Image.asset("assets/icons/png/lluvia.png");
    }
    if (neu.contains(value)) {
      return Image.asset("assets/icons/png/nieve.png");
    }

    return Image.asset("assets/icons/png/poco_nublado.png");
  }
}
