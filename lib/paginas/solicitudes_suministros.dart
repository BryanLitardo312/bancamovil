import 'package:bancamovil/paginas/detalle_suministros.dart';
import 'package:bancamovil/paginas/detalle_novedades.dart';
import 'package:bancamovil/paginas/detalle_devoluciones.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:bancamovil/models/database.dart';
//import 'package:bancamovil/models/quejas.dart';
import 'package:bancamovil/componentes/tab_bar.dart';
import 'package:intl/intl.dart';



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
                    elevation: 7,
                      color:Colors.black,
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
                                    value.tipo != 'usuario' ? Text('De: ${item['estacion']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.clip,) : SizedBox.shrink(),
                                    //Text('De: ${item['estacion']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.clip,),
                                    Text(
                                      'MATERIALES: ${item['detalle'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}',
                                      style: const TextStyle(fontSize: 16, color: Colors.white),
                                      overflow: TextOverflow.clip,
                                    ),
                                    Text(
                                      'FECHA: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(item['created_at']))}',
                                      style: const TextStyle(fontSize: 16, color: Colors.white),
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
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 70,
                                      color: Colors.white
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
                    elevation: 7,
                      color:Colors.black,
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
                                    value.tipo != 'usuario' ? Text('DE: ${item['EESS']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.clip,) : SizedBox.shrink(),
                                    Text(
                                      'DETALLE: ${item['DETALLE'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}',
                                      style: const TextStyle(fontSize: 16, color: Colors.white),
                                      overflow: TextOverflow.clip,
                                    ),
                                    Text(
                                      'FECHA: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(item['created_at']))}',
                                      style: const TextStyle(fontSize: 16, color: Colors.white),
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
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 70,
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
                    elevation: 7,
                      color:Colors.black,
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
                                    value.tipo != 'usuario' ? Text('DE: ${item['EESS']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.clip,) : SizedBox.shrink(),
                                    Text(
                                      'DETALLE: ${item['DETALLE'].replaceAll(RegExp(r'[\[\]"]'), '').split(',').join(', ')}',
                                      style: const TextStyle(fontSize: 16, color: Colors.white),
                                      overflow: TextOverflow.clip,
                                    ),
                                    Text(
                                      'FECHA: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(item['created_at']))}',
                                      style: const TextStyle(fontSize: 16, color: Colors.white),
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
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 70,
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
        backgroundColor: Colors.grey[200],
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