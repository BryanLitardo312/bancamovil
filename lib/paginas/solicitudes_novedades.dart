import 'package:flutter/material.dart';
import 'package:bancamovil/componentes/drawer.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:bancamovil/models/database.dart';
import 'package:bancamovil/models/quejas.dart';
import 'package:intl/intl.dart';




class NovedadesR extends StatefulWidget {
  const NovedadesR ({super.key});

  @override
  State<NovedadesR> createState() => _NovedadesRState();


}

class _NovedadesRState extends State<NovedadesR> {
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
            maxHeight: 110,
            minHeight: 110,
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
                  bodega: item['BODEGA'],
                  estacion: item['EESS'],
                  proceso: 'Novedades bancarias',
                  detalle: item['SECUENCIAL'],
                  salida: item['created_at'],
                  observacion: valor.noteController.text.toString(),
                );
                try {
                  //print('Datos a enviar: ${item['NOMBRE']}');
                  await quejasBanco.createForm(newNote);
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
    
    final double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<Datamodel>(
      builder:(context,value,child)=> Scaffold(
      backgroundColor: Colors.grey[900],
      drawer: Drawer(
        child: MyDrawer(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'lib/imagenes/Alborada.jpeg', // Reemplaza con la ruta de tu imagen
                width: double.infinity,
                height: screenHeight*0.35, // Ajusta la altura según sea necesario
                fit: BoxFit.cover,
              ),
              SizedBox(height: screenHeight*0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Historial',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.shopping_cart_checkout,size:30,color: Colors.white,)
                ],
              ),
              SizedBox(height: screenHeight*0.03),
              Expanded(
                child: value.solicitudes_novedades.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'No hay datos registrados.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    shrinkWrap: true,
                    itemCount: value.solicitudes_novedades.length, // Número de elementos en la lista
                    itemBuilder: (context, index) {
                      
                      final item = value.solicitudes_novedades[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical:10),
                        child: Card(
                          elevation: 5, // Sombra para la tarjeta
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15), // Bordes redondeados
                          ),
                          color:Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0), // Espaciado interno
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('Solicitud #${item['id']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color:Colors.white),),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                  //Text('${item['process']}'=='Novedades bancarias' ? 'Secuencial: ${item['detail']}': 'Materiales: ${item['detail']}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                value.tipo!='usuario' ? Text('${item['EESS']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.white),overflow:TextOverflow.clip) : SizedBox.shrink(),
                                const SizedBox(height: 5),
                                Text('Descripción: ${item['DETALLE']}',style: TextStyle(fontSize: 15,color:Colors.white),overflow:TextOverflow.clip),
                                const SizedBox(height: 5),
                                Text('Monto: ${item['SIGNO']} \$${item['VALOR']}',style: TextStyle(fontSize: 15,color:Colors.white),overflow:TextOverflow.clip),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text('Emisión: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(item['created_at']))}',style: TextStyle(fontSize: 15,color:Colors.white),overflow:TextOverflow.clip),
                                    const SizedBox(width: 5),
                                    Icon(Icons.calendar_month_outlined,color:Colors.white),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () => value.tipo == 'usuario'
                                          ? _submitForm(item)
                                          : ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Servicio no disponible',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                      icon: const Icon(Icons.notifications_active),
                                      label: const Text('Notificar'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ]
                              ),
                            ),
                          ),
                        );
                      
                    },
                  ),
                ),      
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.only(left:12),
                    child: const Icon(
                        Icons.arrow_circle_left, // Cambia por el icono que necesites
                        color: Colors.black,
                        size: 50,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}