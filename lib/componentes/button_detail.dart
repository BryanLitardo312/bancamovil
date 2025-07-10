import 'package:flutter/material.dart';

// ignore: camel_case_types
class MyButton_detail extends StatelessWidget{
  //final void Function()? onTap;
  final VoidCallback onTap;
  final Widget child;

  const MyButton_detail({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        //width: MediaQuery.of(context).size.width * 0.75,
        //padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          //color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[900] ?? Colors.black, width: 2),
        ),
        child: child,
      ),
    );
  }
}

class MyButton2 extends StatelessWidget{
  //final void Function()? onTap;
  final VoidCallback onTap;
  final Widget child;

  const MyButton2({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        //width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: Colors.grey[900] ?? Colors.black, width: 2),
        ),
        child: child,
      ),
    );
  }
}