import 'package:flutter/material.dart';

class DetalleSolicitudScreen extends StatelessWidget {
  final Map<String, dynamic> solicitud;

  const DetalleSolicitudScreen({Key? key, required this.solicitud}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de la Solicitud #${solicitud['requests']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Solicitud #${solicitud['requests']}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (solicitud['estacion'] != null)
              Text(
                "Origen: ${solicitud['estacion']}",
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 10),
            Text(
              "Materiales: ${solicitud['detalle'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}",
              style: TextStyle(fontSize: 16),
            ),
            // Aquí puedes agregar más detalles según tu estructura de datos
          ],
        ),
      ),
    );
  }
}