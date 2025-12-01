import 'package:flutter/material.dart';
import 'provincias_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Credenciales válidas (elegidas para la práctica)
  final String _validUser = 'admin@example.com';
  final String _validPass = 'flutter';

  // Expresión regular para validar email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _showErrorDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error de autenticación'),
          content: const Text('Usuario o contraseña incorrectos.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // cerrar diálogo
              },
              child: const Text('Volver'),
            ),
            TextButton(
              onPressed: () {
                // rellenar con credenciales válidas y cerrar diálogo
                _userController.text = _validUser;
                _passController.text = _validPass;
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('Rellenar usuario'),
            ),
          ],
        );
      },
    );
  }

  void _tryLogin() {
    if (!_formKey.currentState!.validate()) return;

    final user = _userController.text.trim();
    final pass = _passController.text;

    if (user == _validUser && pass == _validPass) {
      // Navegar a la pantalla de Provincias y reemplazar la de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProvinciasScreen()),
      );
    } else {
      _showErrorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario de Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'ejemplo@correo.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduce el email';
                  }
                  if (!_isValidEmail(value.trim())) {
                    return 'Introduce un email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce la contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _tryLogin,
                child: const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
