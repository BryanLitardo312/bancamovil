import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  //final void Function()? onTap;
  final VoidCallback onTap;
  final Widget child;

  const MyButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        //width: MediaQuery.of(context).size.width * 0.27,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          //borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: Colors.black87, width: 2),
        ),
        child: child,
      ),
    );
  }
}


