/*import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SetNewPasswordPage extends StatefulWidget {
  final Uri redirectUri; // Recibe la URI de redirección
  const SetNewPasswordPage({super.key, required this.redirectUri});

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void setNewPassword() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Las contraseñas no coinciden.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Recupera la sesión desde la URL
      final response = await Supabase.instance.client.auth.getSessionFromUrl(widget.redirectUri);
      

      // Establece la nueva contraseña
      final updateResponse = await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: passwordController.text),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contraseña restablecida con éxito.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Establecer Nueva Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Nueva Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmar Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: setNewPassword,
              child: const Text('Restablecer Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}*/