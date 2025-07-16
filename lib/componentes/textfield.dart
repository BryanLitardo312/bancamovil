import 'package:flutter/material.dart';

class Textfield extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon? suffixIcon;
  
  const Textfield({super.key, required this.controller, required this.hintText, required this.obscureText,required this.suffixIcon,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, 
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[900],
              overflow: TextOverflow.ellipsis,),
            suffixIcon: suffixIcon,
            //border: InputBorder.none,
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
      child: Container(
        height: 50,
        child: TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, 
                width: 2,
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
