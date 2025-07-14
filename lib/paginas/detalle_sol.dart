import 'package:flutter/material.dart';

class DetalleSolicitudScreen extends StatefulWidget {
  final Map<String, dynamic> solicitud;
  
  const DetalleSolicitudScreen({Key? key, required this.solicitud}) : super(key: key);
  
  @override
  _DetalleSolicitudScreenState createState() => _DetalleSolicitudScreenState();


}
class _DetalleSolicitudScreenState extends State<DetalleSolicitudScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  
  
  void initState() {
    super.initState();
    //final value = Provider.of<Datamodel>(context, listen: false);
    _nombreController = TextEditingController();
    _apellidoController = TextEditingController();// Inicializa con el valor de la base de datos
  }

  void dispose() {
    _nombreController.clear();
    _apellidoController.clear(); // Limpia el controlador al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: const Text('Perfil'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left:12),
              child: const Icon(
                  Icons.arrow_circle_left_outlined, // Cambia por el icono que necesites
                  color: Colors.white,
                  size: 50,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  child: Text('${widget.solicitud['requests']}',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.grey[900]),),
                  ),
              ),
            ),
            const SizedBox(height: 10),
            Text('# Orden',
            style:TextStyle(fontSize: 25,color:Colors.white,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              width:screenWidth*0.80,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Text('${widget.solicitud['estacion']}', style:TextStyle(fontSize: 17,color:Colors.white,fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 20),
            Container(
              width:screenWidth*0.80,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Text('Solicitud: ${widget.solicitud['detalle'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}', style:TextStyle(fontSize: 17,color:Colors.white)),
            ),
            const SizedBox(height: 20),
            Container(
              width:screenWidth*0.80,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Text('Solicitud: ${widget.solicitud['detalle'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}', style:TextStyle(fontSize: 17,color:Colors.white)),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                //controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      /*appBar: AppBar(
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
      ),*/
    );
  }
}
