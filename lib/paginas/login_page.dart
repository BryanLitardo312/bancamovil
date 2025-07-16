import 'package:bancamovil/auth/auth.dart';
import 'package:bancamovil/componentes/button_login.dart';
import 'package:flutter/material.dart';
import 'package:bancamovil/componentes/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _rememberMe = false;
  int failedAttempts = 0; // Contador de intentos fallidos
  bool isUserBlocked = false; 

  @override
  void initState() {
    super.initState();
    _loadSavedEmail(); // Cargar el correo guardado al iniciar
  }

  // Cargar el correo guardado
  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailcontroller.text = prefs.getString('saved_email') ?? '';
      _rememberMe = prefs.getString('saved_email') != null;
    });
  }
  // Guardar o borrar el correo según el checkbox
  Future<void> _handleRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = value;
    });
    if (value) {
      await prefs.setString('saved_email', emailcontroller.text);
    } else {
      await prefs.remove('saved_email');
    }
  }

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
        // Guardar el correo si "Recordarme" está activado
        if (_rememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('saved_email', emailcontroller.text);
        }
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
    //final double screenHeight = MediaQuery.of(context).size.height;
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
              //const SizedBox(height: 60),
              Image.asset('lib/imagenes/logo-primax.png', width: screenWidth*0.65),
              const SizedBox(height: 50),
              //const Text('Bienvenido', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Textfield(
                controller: emailcontroller,
                hintText: 'Correo electrónico',
                obscureText: false,
                suffixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 15),
              Textfield2(
                controller: passwordcontroller,
                obscureText: _obscureText,
                hintText: 'Contraseña',
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) => _handleRememberMe(value!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Bordes redondeados
                      ),
                      side: BorderSide(
                        color: Colors.grey[800]!, // Color del borde
                        width: 2,
                      ),
                      activeColor: Colors.blue, // Color del checkbox
                    ),
                    const Text('Recordar mi correo'),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ButtonLogin(
                onTap: login,
                text: 'Iniciar sesión',
                icon: Icons.login,
              ),
            ],
            
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}