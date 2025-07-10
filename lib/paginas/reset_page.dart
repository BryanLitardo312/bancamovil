import 'package:flutter/material.dart';
import 'package:bancamovil/componentes/textfield.dart';
import 'package:bancamovil/componentes/button_login.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
//import 'package:bancamovil/auth/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPage extends StatefulWidget {
  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final TextEditingController emailcontroller = TextEditingController();
  //final TextEditingController passwordcontroller = TextEditingController();
  //final TextEditingController confirmpasswordcontroller = TextEditingController();
  
  void _ResetPass() async {
    final email = emailcontroller.text.trim();
    
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingresa tu correo electrónico.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

  try {
    await Supabase.instance.client.auth.resetPasswordForEmail(
      email,
      redirectTo: "com.example.bancamovil://reset-password",
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Correo de restablecimiento enviado.'),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
  void _handleRedirect(Uri uri) async {
    // Maneja la redirección cuando el usuario hace clic en el enlace del correo
    try {
      final response = await Supabase.instance.client.auth.getSessionFromUrl(uri);
      

      // Navega a la página para establecer la nueva contraseña
      Navigator.pushNamed(context, '/set-new-password', arguments: uri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al manejar la redirección: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build (BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left:12),
              child: const Icon(
                  Icons.arrow_circle_left_outlined, // Cambia por el icono que necesites
                  color: Colors.black,
                  size: 50,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:screenHeight*0.15),
            Image.asset('lib/imagenes/primax_logo.png', width: screenWidth*0.7),
            SizedBox(height:screenHeight*0.01),
            Text('Ingrese su correo empresarial',style: TextStyle(fontSize: 17),),
            const SizedBox(height: 15),
            Textfield(
              controller: emailcontroller,
              hintText: 'Correo electrónico',
              obscureText: false,
              suffixIcon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 16),
            ButtonLogin(
              onTap: (){},
              text: 'Restablecer contraseña',
              icon: Icons.recycling,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}