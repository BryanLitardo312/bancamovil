import 'package:flutter/material.dart';
import 'package:bancamovil/componentes/textfield.dart';
import 'package:bancamovil/componentes/button_login.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bancamovil/auth/auth.dart';

class RegistroPage extends StatefulWidget {
  final void Function()? onTap;
  const RegistroPage({super.key, required this.onTap});
  
  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller = TextEditingController();
  
  void register() async {
    final _authService = AuthService();
    if (passwordcontroller.text == confirmpasswordcontroller.text) {
      try {
        await _authService.signUp(email: emailcontroller.text, password: passwordcontroller.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          ),
          );
      }
    }
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Las contraseñas no coinciden.'),
        ),
      );
    }
    
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/imagenes/primax_logo2.png', width: 200),
            /*Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Colors.grey[900],
            ),*/
            const SizedBox(height: 30),
            Textfield(
              controller: emailcontroller,
              hintText: 'Correo electrónico *',
              obscureText: false,
              suffixIcon: const Icon(Icons.email_outlined),
            ),
            //const SizedBox(height: 10),
            Textfield(
              controller: passwordcontroller,
              hintText: 'Contraseña *',
              obscureText: true,
              suffixIcon: const Icon(Icons.lock_open_rounded),
            ),
            Textfield(
              controller: confirmpasswordcontroller,
              hintText: 'Confirmar contraseña *',
              obscureText: true,
              suffixIcon: const Icon(Icons.lock_open_rounded),
            ),
            const SizedBox(height: 10),
            ButtonLogin(
              onTap: register,
              text: 'REGISTRARSE',
              icon: Icons.app_registration_outlined,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ya tienes cuenta?', style: TextStyle(color: Colors.grey[900],fontSize: 15)),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Inicia Sesión', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold,fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}