import 'package:flutter/material.dart';

class DividerWithTitle extends StatelessWidget {
  final String title;

  const DividerWithTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.grey[900],
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[900],
            thickness: 1,
          ),
        ),
      ],
    );
  }
}


class DividerWithTitle2 extends StatelessWidget {
  final String title;

  const DividerWithTitle2({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}