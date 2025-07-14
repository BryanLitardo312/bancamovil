import 'package:bancamovil/auth/auth.dart';
import 'package:bancamovil/componentes/button_login.dart';
import 'package:flutter/material.dart';
import 'package:bancamovil/componentes/textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;
  const LoginPage ({super.key, required this.onTap});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool _obscureText = true;
  int failedAttempts = 0; // Contador de intentos fallidos
  bool isUserBlocked = false; 

  void login() async{

    if (isUserBlocked) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Usuario Bloqueado'),
          content: const Text('Tu cuenta ha sido bloqueada debido a múltiples intentos fallidos.'),
        ),
      );
      return;
    }

    final _authService = AuthService();

      try {    
        await _authService.signInWithPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
        emailcontroller.clear();
        passwordcontroller.clear();
        failedAttempts = 0;

      } catch (e) {
        failedAttempts++;
        if (failedAttempts >= 3) {
          setState(() {
            isUserBlocked = true; // Bloquea al usuario después de 3 intentos fallidos
          });
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Usuario Bloqueado'),
              content: const Text('Tu cuenta ha sido bloqueada debido a múltiples intentos fallidos.'),
            ),
          );
        } else {
          final errorMessage = translateAuthError(e.toString());
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(errorMessage),
            ),
          );
        }
      }
    }
  
    String translateAuthError(String error) {
      if (error.contains('Invalid login credentials')) {
        return 'Credenciales de inicio de sesión inválidas';
      } else if (error.contains('Email not confirmed')) {
        return 'Correo electrónico no confirmado';
      } else if (error.contains('Invalid email format')) {
        return 'Formato de correo electrónico inválido';
      } else if (error.contains('User already registered')) {
        return 'Usuario ya registrado';
      } else if (error.contains('Too many requests')) {
        return 'Demasiados intentos, por favor intente más tarde';
      } else if (error.contains('Weak password')) {
        return 'Contraseña demasiado débil';
      } else if (error.contains('Network error')) {
        return 'Error de conexión a internet';
      } else if (error.contains('User not found')) {
        return 'Usuario no encontrado';
      } else {
        return 'Error desconocido: $error';
      }
  }

  @override
  Widget build (BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(height: 100),
              //Image.asset('lib/imagenes/primax_logo2.png', width: screenWidth*0.9),
              //SizedBox(height: screenHeight*0.31),
              SizedBox(height: screenHeight*0.05),
              Image.asset('lib/imagenes/logo-primax.png', width: screenWidth*0.65),
              SizedBox(height: screenHeight*0.10),
              //const Text('Bienvenido', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Textfield(
                controller: emailcontroller,
                hintText: 'Correo electrónico',
                obscureText: false,
                suffixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 10),
              Textfield2(
                controller: passwordcontroller,
                obscureText: _obscureText,
                hintText: 'Contraseña',
              ),
              const SizedBox(height: 20),
              ButtonLogin(
                onTap: login,
                text: 'Iniciar sesión',
                icon: Icons.login,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Crecemos con', style: TextStyle(color: Colors.black,fontSize: 15),),
                    Text(' energía', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15)),
                    Text(' y', style: TextStyle(color: Colors.black,fontSize: 15)),
                    Text(' pasión', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15)),
                    /*GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/reset-password');
                      },
                      child: Text('¿Olvidó su contraseña?', style: TextStyle(color: Colors.grey[900],fontSize: 16)),
                    ),*/
                  ],
                ),
              ),
            ],
            
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}