import 'package:bancamovil/models/suministros.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:bancamovil/componentes/drawer.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:bancamovil/models/database.dart';
import 'package:bancamovil/models/quejas.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleSuministroScreen extends StatefulWidget {
  final Map<String, dynamic> solicitud;
  
  const DetalleSuministroScreen({Key? key, required this.solicitud}) : super(key: key);
  
  @override
  _DetalleSuministroScreenState createState() => _DetalleSuministroScreenState();


}
class _DetalleSuministroScreenState extends State<DetalleSuministroScreen> {
  final suministrosBanco = SuministrosBanco();
  final quejasBanco = QuejasBanco();
  


  void _submitForm(Map<String, dynamic> item) {
    final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;
    final valor = Provider.of<Datamodel>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        insetPadding: EdgeInsets.symmetric(vertical: 10),
        title: const Text(
          'Notificación',
          style: TextStyle(color: Colors.white)
          ),
        content: ConstrainedBox(
            constraints: BoxConstraints(
            maxWidth: screenWidth*0.70,
            minWidth: screenWidth*0.70,
            ),
            child: IntrinsicHeight(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '¿No ha recibido los soportes?',
                      style:TextStyle(
                        fontSize: 16,
                        color: Colors.white,)
                      ),
                      SizedBox(height: 15),
                      TextField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        controller: valor.noteController,
                        decoration: InputDecoration(
                          isDense: true,
                          counterStyle: TextStyle(color: Colors.white),
                          //contentPadding: EdgeInsets.symmetric(vertical: 8),
                          //labelText: 'Comentarios',
                          hintText: 'Escribe un comentario..',
                          //labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                          hintStyle: TextStyle(color: Colors.white,fontSize: 16),
                        ),
                        maxLines: null,
                      ),
                  ],
                ),
              ),
            ),
          ),
        
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              valor.noteController.clear();
            },
            child: const Text(
              'Cancelar',
              style:TextStyle(
                fontSize: 19,
                color:Colors.white,
                )
              ),
            ),
            TextButton(
              onPressed: () async {
                final newNote = BancoQuejas(
                  //id: DateTime.now().millisecondsSinceEpoch, // O proporciona un ID si es necesario
                  bodega: item['bodega'],
                  estacion: item['estacion'],
                  proceso: 'Suministros',
                  detalle: item['detalle'],
                  salida: item['created_at'],
                  observacion: valor.noteController.text.toString(),
                );
                try {
                  //print('Datos a enviar: ${item['NOMBRE']}');
                  await quejasBanco.createForm(newNote);
                  Navigator.pop(context);
                  //valor.noteController.clear();
                  valor.noteController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notificación enviada correctamente',style: TextStyle(fontSize: 18),),backgroundColor: Colors.green),
                  );
                  //noteController.clear();
                } catch (e) {
                  // Maneja el error si es necesario
                  //print('Error al crear el formulario: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al enviar la solicitud: $e')),
                  );
                }
              },
              child: const Text(
                'Notificar',
                style:TextStyle(
                  fontSize: 19,
                  color:Colors.white,
                  )
                ),
            ),
        ],
      ),   
    );
  }

  void _submitRechazo(Map<String, dynamic> item) {
    final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;
    final valor = Provider.of<Datamodel>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        insetPadding: EdgeInsets.symmetric(vertical: 10),
        title: const Text(
          'Notificación',
          style: TextStyle(color: Colors.white)
          ),
        content: ConstrainedBox(
            constraints: BoxConstraints(
            maxWidth: screenWidth*0.70,
            minWidth: screenWidth*0.70,
            //maxHeight: 110,
            //minHeight: 110,
            ),
            child: IntrinsicHeight(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '¿Los soportes recibidos son incongruentes?',
                      style:TextStyle(
                        fontSize: 16,
                        color: Colors.white,)
                      ),
                      SizedBox(height: 15),
                      TextField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        controller: valor.noteController,
                        decoration: InputDecoration(
                          isDense: true,
                          counterStyle: TextStyle(color: Colors.white),
                          //contentPadding: EdgeInsets.symmetric(vertical: 8),
                          //labelText: 'Comentarios',
                          hintText: 'Escribe un comentario..',
                          //labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                          hintStyle: TextStyle(color: Colors.white,fontSize: 16),
                        ),
                        maxLines: null,
                      ),
                  ],
                ),
              ),
            ),
          ),
        
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              valor.noteController.clear();
            },
            child: const Text(
              'Cancelar',
              style:TextStyle(
                fontSize: 19,
                color:Colors.white,
                )
              ),
            ),
            TextButton(
              onPressed: () async {
                final newNote = Suministros(
                  //id: DateTime.now().millisecondsSinceEpoch, // O proporciona un ID si es necesario
                  requests: item['requests'],
                  COMENTARIO_RECHAZO: valor.noteController.text.toString(),
                  STATUS: 'Rechazado'
                );
                try {
                  //print('Datos a enviar: ${item['NOMBRE']}');
                  await suministrosBanco.updateForm(newNote);
                  Navigator.pop(context);
                  valor.noteController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notificación enviada correctamente',style: TextStyle(fontSize: 18),),backgroundColor: Colors.green),
                  );
                  //noteController.clear();
                } catch (e) {
                  // Maneja el error si es necesario
                  //print('Error al crear el formulario: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al enviar la solicitud: $e')),
                  );
                }
              },
              child: const Text(
                'Notificar',
                style:TextStyle(
                  fontSize: 19,
                  color:Colors.white,
                  )
                ),
            ),
        ],
      ),   
    );
  }
//Expanded(child: Text('${widget.solicitud['DETALLE'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}', style:TextStyle(fontSize: 17,color:Colors.white),overflow: TextOverflow.clip)),
  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<Datamodel>(
      builder:(context,value,child)=> Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Detalles', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left:12),
              child: const Icon(
                  Icons.arrow_circle_left_outlined, // Cambia por el icono que necesites
                  color: Colors.black,
                  size: 50,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text('Estación', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black),),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_history_rounded,color: Colors.grey[800],size:30),
                      const SizedBox(width: 15),
                      Text('${widget.solicitud['estacion']}', style:TextStyle(fontSize: 16,color:Colors.grey[800],fontWeight: FontWeight.bold),overflow: TextOverflow.clip),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Solicitado', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black),),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_month_rounded,color: Colors.grey[800],size:30),
                                const SizedBox(width: 15),
                                Expanded(child: Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.solicitud['created_at'])), style:TextStyle(fontSize: 16,color:Colors.grey[800]),overflow: TextOverflow.clip)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Orden', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black),),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart,color: Colors.grey[800],size:30),
                                const SizedBox(width: 15),
                                Expanded(child: Text(widget.solicitud['requests'].toString(), style:TextStyle(fontSize: 16,color:Colors.grey[800]),overflow: TextOverflow.clip)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Text('Materiales', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black),),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.local_shipping_rounded,color: Colors.grey[800],size:30),
                      const SizedBox(width: 15),
                      Expanded(child: Text('${widget.solicitud['detalle'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}', style:TextStyle(fontSize: 16,color:Colors.grey[800]),overflow: TextOverflow.clip)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                widget.solicitud['URL_PUBLICA'] == null ? 
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width:screenWidth,
                        height:50,
                        child: ElevatedButton.icon(
                          onPressed: () => value.tipo == 'usuario'
                            ? _submitForm(widget.solicitud)
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Servicio no disponible',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                          icon: const Icon(Icons.notifications_active,size:20),
                          label: const Text('Notificar demora',style:TextStyle(fontSize: 17,color:Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 233, 39, 26),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            //content: Text('Archivo disponible en: ${widget.solicitud['URL_PUBLICA']}'),
                            content: Text('Por motivo de seguridad, el archivo se descargará directamente desde la nube..'),
                            duration: const Duration(seconds: 8),
                            action: SnackBarAction(
                              label: 'Abrir',
                              onPressed: () {
                                // Usar el paquete `url_launcher` para abrir en el navegador
                                launchUrl(Uri.parse(widget.solicitud['URL_PUBLICA']));
                              },
                            ),
                          ),
                        ),
                        splashColor: Colors.grey.withOpacity(0.9), // Color del efecto
                        borderRadius: BorderRadius.circular(4), // Bordes redondeados del efecto
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text(
                                'Para descargar los soportes, ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Text(
                                'click aquí',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //const SizedBox(height: 20),
                      SizedBox(
                        width:screenWidth,
                        height:50,
                        child: ElevatedButton.icon(
                          onPressed: () => value.tipo == 'usuario'
                            ? _submitRechazo(widget.solicitud)
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Servicio no disponible',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                          icon: const Icon(Icons.notifications_active,size:20),
                          label: const Text('Rechazar soportes',style:TextStyle(fontSize: 17,color:Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 233, 39, 26),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
    ),
    );
  }
}
