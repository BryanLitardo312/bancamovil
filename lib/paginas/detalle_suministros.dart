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
  //late TextEditingController _quejaController;
  //late TextEditingController _rechazoController;
  final suministrosBanco = SuministrosBanco();
  final quejasBanco = QuejasBanco();
  
  
  void initState() {
    super.initState();
    //final value = Provider.of<Datamodel>(context, listen: false);
    //_quejaController = TextEditingController();
    //_rechazoController = TextEditingController();// Inicializa con el valor de la base de datos
  }

  void dispose() {
    //_quejaController.clear();
    //_rechazoController.clear(); // Limpia el controlador al salir
    super.dispose();
  }

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
            //maxHeight: 110,
            //minHeight: 110,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¿No ha recibido los soportes completos?',
                  style:TextStyle(
                    fontSize: 16,
                    color: Colors.white,)
                  ),
                  SizedBox(height: 15),
                  TextField(
                    maxLength: 100,
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
                    maxLines: 1,
                  ),
              ],
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
            minHeight: 110,
            ),
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
                    maxLines: 1,
                  ),
              ],
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<Datamodel>(
      builder:(context,value,child)=> Scaffold(
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(height: 20),
              //Text('${widget.solicitud}',style:TextStyle(color: Colors.amber)),
              Center(
                child: Text('Solicitud #${widget.solicitud['requests']}',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),overflow: TextOverflow.clip,),
              ),
              const SizedBox(height: 40),
              Container(
                width:screenWidth*0.80,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.location_history_rounded,color: Colors.white,size:30),
                    const SizedBox(width: 15),
                    Text('${widget.solicitud['estacion']}', style:TextStyle(fontSize: 17,color:Colors.white,fontWeight: FontWeight.bold),overflow: TextOverflow.clip),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width:screenWidth*0.80,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.local_shipping_rounded,color: Colors.white,size:30),
                    const SizedBox(width: 15),
                    Expanded(child: Text('${widget.solicitud['detalle'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}', style:TextStyle(fontSize: 17,color:Colors.white),overflow: TextOverflow.clip)),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width:screenWidth*0.80,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_rounded,color: Colors.white,size:30),
                    const SizedBox(width: 15),
                    Expanded(child: Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.solicitud['created_at'])), style:TextStyle(fontSize: 17,color:Colors.white),overflow: TextOverflow.clip)),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              widget.solicitud['URL_PUBLICA'] == null ? 
              SizedBox(
                width:screenWidth*0.80,
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ) : Column(
                children: [
                  SizedBox(
                    width:screenWidth*0.80,
                    height:50,
                    child: ElevatedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Archivo disponible en: ${widget.solicitud['URL_PUBLICA']}'),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'Abrir',
                            onPressed: () {
                              // Usar el paquete `url_launcher` para abrir en el navegador
                              launchUrl(Uri.parse(widget.solicitud['URL_PUBLICA']));
                            },
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.email_rounded,size:20),
                      label: const Text('Descarga online',style:TextStyle(fontSize: 17,color:Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 42, 147, 45),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width:screenWidth*0.80,
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
                      icon: const Icon(Icons.email_rounded,size:20),
                      label: const Text('Reportar',style:TextStyle(fontSize: 17,color:Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 233, 39, 26),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
