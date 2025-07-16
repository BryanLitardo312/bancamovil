import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EnlaceExterno extends StatelessWidget {
  final String url;
  final String texto;
  final TextStyle? estiloTexto;

  const EnlaceExterno({
    Key? key,
    required this.url,
    required this.texto,
    this.estiloTexto,
  }) : super(key: key);

  Future<void> _abrirEnlace() async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _abrirEnlace,
      child: Text(
        texto,
        style: estiloTexto ?? const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}