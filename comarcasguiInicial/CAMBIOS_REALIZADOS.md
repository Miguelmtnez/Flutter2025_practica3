# Cambios Realizados en la Práctica 4

## Fecha: 26 de noviembre de 2025

---

## 1. ✅ Validación de Email en el Formulario de Login

### Archivo modificado: `lib/screens/login_screen.dart`

**Problema anterior:**
- El campo de usuario aceptaba cualquier texto
- No había validación de formato de email

**Solución implementada:**
- Se agregó validación de email usando expresión regular
- La expresión regular valida el formato estándar de email: `nombre@dominio.extension`
- Se cambió el tipo de teclado a `TextInputType.emailAddress` para mejor UX
- Se actualizó el usuario válido a `admin@example.com`

**Código de validación:**
```dart
bool _isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}

// En el validator del TextFormField:
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Introduce el email';
  }
  if (!_isValidEmail(value.trim())) {
    return 'Introduce un email válido';
  }
  return null;
}
```

---

## 2. ✅ Implementación de NavigationBar en Pantalla de Comarca

### Archivo nuevo: `lib/screens/infocomarca_screen.dart`

**Problema anterior:**
- No existía un NavigationBar cuando se seleccionaba una comarca
- Las pantallas `infocomarca_general.dart` e `infocomarca_detall.dart` estaban separadas
- No se cumplía el requisito de tener pestañas para navegar entre información

**Solución implementada:**
- Se creó una nueva pantalla `InfoComarcaScreen` con `StatefulWidget`
- Se implementó un `NavigationBar` con dos pestañas:
  - **Info General**: Muestra imagen, capital, población y descripción
  - **Info Detallada**: Muestra información meteorológica, población y coordenadas
- Se usa `setState()` para cambiar entre pestañas

**Estructura del NavigationBar:**
```dart
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
)
```

### Archivo modificado: `lib/screens/comarcas_screen.dart`

**Cambios:**
- Se cambió la navegación de `InfoComarcaDetall` a `InfoComarcaScreen`
- Ahora al tocar una comarca se navega a la nueva pantalla con NavigationBar

---

## 3. ✅ Mejora en el Manejo de Imágenes

### Archivo modificado: `lib/screens/comarcas_screen.dart`

**Problema anterior:**
- Las imágenes no mostraban feedback visual mientras cargaban
- El código solo verificaba `http` en lugar de `http://` o `https://`

**Solución implementada:**
- Se agregó `loadingBuilder` para mostrar un `CircularProgressIndicator` mientras carga
- Se mejoró la detección de URLs para ser más precisa
- Se mantiene el `errorBuilder` para mostrar imagen de fallback

**Código mejorado:**
```dart
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
  // ... resto del código para assets
}
```

### Archivo nuevo: `lib/screens/infocomarca_screen.dart`

**Mejoras en esta nueva pantalla:**
- Implementación completa de carga de imágenes con loading indicator
- Manejo robusto de errores
- Soporte para imágenes de red y assets
- Fallback visual consistente

---

## 4. ✅ Estructura de Navegación Correcta

**Flujo actual (corregido):**
```
Login (con validación de email)
  ↓ pushReplacement()
Provincias
  ↓ push() + provinceName
Comarcas (filtradas por provincia en AppBar)
  ↓ push() + comarcaId
InfoComarcaScreen con NavigationBar
  ├─ Pestaña 1: Info General
  └─ Pestaña 2: Info Detallada
```

**Archivos involucrados:**
- `main.dart`: Inicia con `LoginScreen`
- `login_screen.dart`: Navega a `ProvinciasScreen` con `pushReplacement`
- `provincias_screen.dart`: Navega a `ComarcasScreen` con `push`
- `comarcas_screen.dart`: Navega a `InfoComarcaScreen` con `push`
- `infocomarca_screen.dart`: Muestra NavigationBar con dos pestañas

---

## 5. ✅ Documentación Actualizada

### Archivo modificado: `DOCUMENTACION_PRACTICA4.md`

**Cambios realizados:**
- Actualizada la sección de objetivos cumplidos
- Agregada documentación completa de `InfoComarcaScreen`
- Actualizado el diagrama de flujo de navegación
- Actualizadas las credenciales de prueba
- Agregada explicación del NavigationBar
- Actualizada la estructura del proyecto

---

## Resumen de Archivos

### Archivos Nuevos:
- ✨ `lib/screens/infocomarca_screen.dart` - Pantalla principal con NavigationBar

### Archivos Modificados:
- 🔄 `lib/screens/login_screen.dart` - Validación de email
- 🔄 `lib/screens/comarcas_screen.dart` - Mejora de imágenes y navegación
- 🔄 `DOCUMENTACION_PRACTICA4.md` - Documentación completa actualizada

### Archivos Sin Cambios (pero utilizados):
- ✓ `lib/screens/provincias_screen.dart`
- ✓ `lib/screens/infocomarca_general.dart`
- ✓ `lib/screens/infocomarca_detall.dart`
- ✓ `lib/screens/widgets/my_weather_info.dart`
- ✓ `lib/models/comarca.dart`
- ✓ `lib/models/provincia.dart`
- ✓ `lib/repository/repository_ejemplo.dart`
- ✓ `lib/themes/tema_comarcas.dart`
- ✓ `lib/main.dart`

---

## Testing y Verificación

### ✅ Compilación
- No hay errores de compilación
- Todas las dependencias resueltas correctamente

### ✅ Validación de Email
- Email vacío: ❌ "Introduce el email"
- Email inválido (sin @): ❌ "Introduce un email válido"
- Email inválido (sin dominio): ❌ "Introduce un email válido"
- Email válido: ✅ Permite continuar

### ✅ NavigationBar
- Se muestra correctamente en la parte inferior
- Las pestañas cambian el contenido dinámicamente
- Los iconos cambian entre estado seleccionado y no seleccionado
- La navegación es fluida

### ✅ Carga de Imágenes
- Muestra indicador de carga mientras descarga
- Muestra imagen de fallback en caso de error
- Soporta URLs y assets correctamente

---

## Credenciales de Prueba

**Email:** `admin@example.com`  
**Contraseña:** `flutter`

---

## Comandos para Ejecutar

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en Windows
flutter run -d windows

# Ejecutar en Chrome
flutter run -d chrome

# Compilar para producción
flutter build windows
```

---

**Fin del documento de cambios**
