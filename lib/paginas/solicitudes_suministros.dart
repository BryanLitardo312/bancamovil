import 'package:bancamovil/paginas/detalle_suministros.dart';
import 'package:bancamovil/paginas/detalle_novedades.dart';
import 'package:bancamovil/paginas/detalle_devoluciones.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:bancamovil/models/database.dart';
//import 'package:bancamovil/models/quejas.dart';
import 'package:bancamovil/componentes/tab_bar.dart';
//import 'package:intl/intl.dart';



class Historial extends StatefulWidget {
  const Historial ({super.key});

  @override
  State<Historial> createState() => _HistorialState();


}

class _HistorialState extends State<Historial> with SingleTickerProviderStateMixin {
  final quejasBanco = QuejasBanco();
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /*void _submitForm(Map<String, dynamic> item) {
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
                  '¿No llegó completo el pedido?',
                  style:TextStyle(
                    fontSize: 16,
                    color: Colors.white,)
                  ),
                  const SizedBox(height: 15),
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
  }*/

  
  Widget _buildSolicitudesList(Datamodel value) {
    return value.solicitudes_suministros.isEmpty
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
            //padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: value.solicitudes_suministros.length,
            itemBuilder: (context, index) {
              final item = value.solicitudes_suministros[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleSuministroScreen(solicitud: item),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                      color:Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black, // Color del borde
                          width: 1.0, // Grosor del borde
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                            children: [
                              Expanded(
                                flex:4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sol. #${item['requests']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ), 
                                    const SizedBox(height: 5),
                                    value.tipo != 'usuario' ? Text('De: ${item['estacion']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.clip,) : SizedBox.shrink(),
                                    Text(
                                      '${item['detalle'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}',
                                      style: const TextStyle(fontSize: 15, color: Colors.white),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex:1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_right_outlined,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
                      
                  ),
                
                ),
              );
            },
        );
  }
  
  Widget _buildNovedadesList(Datamodel value) {
    return value.solicitudes_suministros.isEmpty
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
            //padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: value.solicitudes_novedades.length,
            itemBuilder: (context, index) {
              final item = value.solicitudes_novedades[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleNovedadScreen(solicitud: item),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                      color:Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black, // Color del borde
                          width: 1.0, // Grosor del borde
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                            children: [
                              Expanded(
                                flex:4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sol. #${item['id']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ), 
                                    const SizedBox(height: 5),
                                    value.tipo != 'usuario' ? Text('De: ${item['EESS']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.clip,) : SizedBox.shrink(),
                                    Text(
                                      '${item['DETALLE'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}',
                                      style: const TextStyle(fontSize: 15, color: Colors.white),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex:1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_right_outlined,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
                      
                  ),
                
                ),
              );
            },
        );
  }
  Widget _buildDevolucionesList(Datamodel value) {
    return value.solicitudes_suministros.isEmpty
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
            //padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: value.solicitudes_novedades.length,
            itemBuilder: (context, index) {
              final item = value.solicitudes_novedades[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleDevolucionScreen(solicitud: item),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                      color:Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black, // Color del borde
                          width: 1.0, // Grosor del borde
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                            children: [
                              Expanded(
                                flex:4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sol. #${item['id']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ), 
                                    const SizedBox(height: 5),
                                    value.tipo != 'usuario' ? Text('De: ${item['EESS']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.clip,) : SizedBox.shrink(),
                                    Text(
                                      '${item['DETALLE'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}',
                                      style: const TextStyle(fontSize: 15, color: Colors.white),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex:1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_right_outlined,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
                      
                  ),
                
                ),
              );
            },
        );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 0.35;

    return Consumer<Datamodel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[900],
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: Image.asset(
                'lib/imagenes/Alborada.jpeg',
                fit: BoxFit.cover,
              ),
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
                          Icons.arrow_circle_left_outlined, // Cambia por el icono que necesites
                          color: Colors.black,
                          size: 50,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
            Positioned(
              top: imageHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  MyTabBar(tabController: _tabController),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildSolicitudesList(value),
                        _buildNovedadesList(value),
                        _buildDevolucionesList(value),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




}