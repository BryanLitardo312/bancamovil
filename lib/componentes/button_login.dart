import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final IconData? icon;
  const ButtonLogin({super.key, required this.onTap, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        //width: MediaQuery.of(context).size.width * 0.26,
        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(left: 50,right: 50),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(color: Colors.grey[900] ?? Colors.black, width: 1),
        ),
        child: Center(
          child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: Colors.white,size:25),
              ],
            ),
        ),
    ),);
  }
}



class ButtonLogin2 extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final IconData? icon;
  const ButtonLogin2({super.key, required this.onTap, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical:5),
        //margin: const EdgeInsets.only(left: 60,right: 60),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 14, 97, 136),
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: Colors.grey[900] ?? Colors.black, width: 2),
        ),
        child: Center(
          child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 7),
                Icon(icon, color: Colors.white,size:25),
              ],
            ),
        ),
    ),);
  }
}