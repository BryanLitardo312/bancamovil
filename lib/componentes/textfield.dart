import 'package:flutter/material.dart';

class Textfield extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;

  
  const Textfield({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        height: 45,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, 
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[900],
              overflow: TextOverflow.ellipsis,
            ),
            suffixIcon: Icon(Icons.email_outlined),
          ),
        ),
      ),
    );
  }
}


class Textfield2 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const Textfield2({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  _Textfield2State createState() => _Textfield2State();
}

class _Textfield2State extends State<Textfield2> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText; // Inicializa el estado con el valor recibido
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        height: 45,
        child: TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, 
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[900]),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText; // Cambia el estado
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}



class TextfieldPerfil extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  
  const TextfieldPerfil({super.key, required this.controller, required this.hintText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          fillColor: Colors.white,
          filled:true,
          prefixIcon: Icon(icon),
          enabledBorder: InputBorder.none,    // Elimina borde cuando no está enfocado
          focusedBorder: InputBorder.none,    // Elimina borde cuando está enfocado
          //contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        ),
      );
  }
}