import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
//import 'package:bancamovil/componentes/drawer.dart';
import 'package:bancamovil/models/database.dart';
import 'package:bancamovil/models/novedadesbanco.dart';
import 'package:bancamovil/models/devoluciones.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Busqueda extends StatefulWidget {
  const Busqueda ({super.key});

  @override
  State<Busqueda> createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  final novedadesBanco = NovedadesBanco();
  final devolucionesBanco = DevolucionesBanco();
  int _notificationCount = 0;
  String? _filtroSeleccionado = 'Seleccione';
  List<String> _opcionesFiltro = ['Seleccione'];
  List<String> _ultimosNombresUnicos = [];
  late Stream<List<Map<String, dynamic>>> _streamFiltrado;

  @override
  void initState() {
    super.initState();
    final value = Provider.of<Datamodel>(context, listen: false);
    value.tipo=='usuario' ? _streamFiltrado = _filtrarNovedades(value.novedadesStream) : _streamFiltrado = _filtrarNovedades_estaciones(value.novedadesStream);
  }

  bool _listasIguales(List<String> lista1, List<String> lista2) {
    if (lista1.length != lista2.length) return false;
    for (int i = 0; i < lista1.length; i++) {
      if (lista1[i] != lista2[i]) return false;
    }
    return true;
  }

  Stream<List<Map<String, dynamic>>> _filtrarNovedades(
      Stream<List<Map<String, dynamic>>> source) {
    return source.map((novedades) {
      // Actualizar opciones de filtro si hay nuevos datos
      final nombresUnicos = novedades
          .map((item) => item['NOMBRE']?.toString() ?? '')
          .where((nombre) => nombre.isNotEmpty)
          .toSet()
          .toList();
      
      if (!_listasIguales(_ultimosNombresUnicos, nombresUnicos)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _ultimosNombresUnicos = List.from(nombresUnicos);
              _opcionesFiltro = ['Seleccione', ...nombresUnicos];
            });
          }
        });
      }

      // Aplicar filtro
      if (_filtroSeleccionado == 'Seleccione' || _filtroSeleccionado == null) {
        return novedades;
      } else {
        return novedades.where((novedad) => 
            novedad['NOMBRE'] == _filtroSeleccionado).toList();
      }
    });
  }

  Stream<List<Map<String, dynamic>>> _filtrarNovedades_estaciones(
      Stream<List<Map<String, dynamic>>> source) {
    return source.map((novedades) {
      // Actualizar opciones de filtro si hay nuevos datos
      final nombresUnicos = novedades
          .map((item) => item['ESTACION']?.toString() ?? '')
          .where((nombre) => nombre.isNotEmpty)
          .toSet()
          .toList();
      
      if (!_listasIguales(_ultimosNombresUnicos, nombresUnicos)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _ultimosNombresUnicos = List.from(nombresUnicos);
              _opcionesFiltro = ['Seleccione', ...nombresUnicos];
            });
          }
        });
      }

      // Aplicar filtro
      if (_filtroSeleccionado == 'Seleccione' || _filtroSeleccionado == null) {
        return novedades;
      } else {
        return novedades.where((novedad) => 
            novedad['ESTACION'] == _filtroSeleccionado).toList();
      }
    });
  }

  void _submitForm(Map<String, dynamic> item) {
    final valor = Provider.of<Datamodel>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          'Confirmación',
          style: TextStyle(color: Colors.white)
          ),
        content: const Text(
          'Se solicitarán todos los soportes para su validación',
          style:TextStyle(
            fontSize: 17,
            color: Colors.white,)
          ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              //noteController.clear();
            },
            child: const Text(
              'Cancelar',
              style:TextStyle(
                fontSize: 18,
                color:Colors.white,
                )
            ),
          ),
          TextButton(
            onPressed: () async {
              final newNote = BancoNovedades(
                id: 1, // O proporciona un ID si es necesario
                No: item['No'],
                FECHA: item['FECHA'],
                REF: item['REF'],
                LUGAR: item['LUGAR'],
                DETALLE: item['DETALLE'],
                SECUENCIAL: item['SECUENCIAL'],
                SIGNO: item['SIGNO'],
                VALOR: double.parse(item['VALOR'].toString()),
                DESCRIPCION: item['DESCRIPCION'],
                EESS: valor.nombreEstacion?? 'No disponible',
                BODEGA: valor.bodegaEstacion?? 'No disponible',
              );
              try {
                //print('Datos a enviar: ${item['NOMBRE']}');
                await novedadesBanco.createForm(newNote);
                Navigator.pop(context);
                setState(() {
                  _notificationCount++; // Incrementar contador
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Solicitud enviada correctamente',style: TextStyle(fontSize: 18),),backgroundColor: Colors.green),
                );
                //noteController.clear();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al enviar la solicitud: $e')),
                );
              }
            },
            child: const Text(
              'De acuerdo',
              style:TextStyle(
                fontSize: 18,
                color:Colors.white,
                )
              ),
          ),
        ],
      ),   
    );
  }

  void _enviar_devoluciones(Map<String, dynamic> item) {
    final valor = Provider.of<Datamodel>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          'Confirmación',
          style: TextStyle(color: Colors.white)
          ),
        content: const Text(
          'Se solicitará la devolución del ejemplar en mal estado.',
          style:TextStyle(
            fontSize: 17,
            color: Colors.white,)
          ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              //noteController.clear();
            },
            child: const Text(
              'Cancelar',
              style:TextStyle(
                fontSize: 18,
                color:Colors.white,
                )
            ),
          ),
          TextButton(
            onPressed: () async {
              final newNote = BancoDevoluciones(
                id: 1, // O proporciona un ID si es necesario
                No: item['No'],
                FECHA: item['FECHA'],
                REF: item['REF'],
                LUGAR: item['LUGAR'],
                DETALLE: item['DETALLE'],
                SECUENCIAL: item['SECUENCIAL'],
                SIGNO: item['SIGNO'],
                VALOR: double.parse(item['VALOR'].toString()),
                DESCRIPCION: item['DESCRIPCION'],
                EESS: valor.nombreEstacion?? 'No disponible',
                BODEGA: valor.bodegaEstacion?? 'No disponible',
              );
              try {
                //print('Datos a enviar: ${item['NOMBRE']}');
                await devolucionesBanco.createForm(newNote);
                Navigator.pop(context);
                setState(() {
                  _notificationCount++; // Incrementar contador
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Solicitud enviada correctamente',style: TextStyle(fontSize: 18),),backgroundColor: Colors.green),
                );
                //noteController.clear();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al enviar la solicitud: $e')),
                );
              }
            },
            child: const Text(
              'De acuerdo',
              style:TextStyle(
                fontSize: 18,
                color:Colors.white,
                )
              ),
          ),
        ],
      ),   
    );
  }
  
  // Method to compare two lists for equality

  @override
  Widget build(BuildContext context) {
    //final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<Datamodel>(
      builder:(context,value,child){
      return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'lib/imagenes/Portada_Previsora.jpeg', // Reemplaza con la ruta de tu imagen
                width: double.infinity,
                height: screenHeight*0.35, // Ajusta la altura según sea necesario
                fit: BoxFit.cover,
              ),
              
              const SizedBox(height: 40,), // Añadir un espacio entre el Container y el texto

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: _filtroSeleccionado,
                  dropdownColor: Colors.black,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3),
                    ),
                    filled: true,
                    fillColor: Colors.grey[900],
                    prefixIcon: Icon(Icons.filter_alt_rounded, color: Colors.white),
                  ),
                  items: _opcionesFiltro.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white,fontSize: 16),
                      ),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  style: TextStyle(color: Colors.white),
                  onChanged: (String? nuevoValor) {
                    setState(() {
                      _filtroSeleccionado = nuevoValor;
                      value.tipo=='usuario' ? _streamFiltrado = _filtrarNovedades(value.novedadesStream) : _streamFiltrado = _filtrarNovedades_estaciones(value.novedadesStream);
                    });
                  },
                ),
              ),
              SizedBox(height: screenHeight*0.01),
              
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    //border: Border(top: BorderSide(color: Colors.white, width: 3)),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _streamFiltrado,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No hay datos disponibles', style: TextStyle(color: Colors.white)));
                      }
                      final novedades = snapshot.data!;
                      return ListView.builder(
                        //padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        itemCount: novedades.length, // Número de elementos en la lista
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Card(
                              elevation: 7,
                              color:Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Slidable(
                                  key: Key(novedades[index]['SECUENCIAL']),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(), // Deslizar hacia la izquierda
                                    extentRatio: 0.70,
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          value.tipo=='usuario' ? _enviar_devoluciones(novedades[index]) : ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Servicio no disponible",style:TextStyle(fontSize: 18))),
                                          );
                                        },
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        icon: Icons.attach_money_rounded,
                                        flex:4,
                                        label: 'Retorno',
                                        
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          value.tipo=='usuario' ? _submitForm(novedades[index]) : ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Servicio no disponible",style:TextStyle(fontSize: 18))),
                                          );
                                        },
                                        backgroundColor: const Color.fromARGB(255, 233, 39, 26),
                                        foregroundColor: Colors.white,
                                        icon: Icons.folder_copy_rounded,
                                        flex:4,
                                        label: 'Soportes',
                                        
                                        // Removed invalid 'style' parameter
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: ListTile(
                                        title: Text(novedades[index]['NOMBRE'],style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Colors.white),overflow: TextOverflow.ellipsis,),
                                        subtitle: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Icon(Icons.local_shipping_rounded,color:Colors.white),
                                                SizedBox(width: 10),
                                                Expanded(child: Text('${novedades[index]['DETALLE']}',style:TextStyle(fontSize: 15,color:Colors.white),overflow: TextOverflow.ellipsis, )),
                                              ],
                                              ),
                                            Row(
                                              children: [
                                                Icon(Icons.key,color:Colors.white),
                                                SizedBox(width: 10),
                                                Expanded(child: Text('${novedades[index]['SECUENCIAL']}',style:TextStyle(fontSize: 15,color:Colors.white),overflow: TextOverflow.ellipsis, )),
                                              ],
                                            ),
                                            //Text('#${novedades[index]['SECUENCIAL']}.',style:TextStyle(fontSize: 15,color:Colors.white),overflow: TextOverflow.clip, ),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_month_outlined,color:Colors.white),
                                                SizedBox(width: 10),
                                                Expanded(child: Text('${novedades[index]['FECHA']}',style:TextStyle(fontSize: 15,color:Colors.white),overflow: TextOverflow.ellipsis, )),
                                              ],
                                              ),
                                          ],
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              novedades[index]['VALOR2'].toStringAsFixed(1),
                                              style: TextStyle(fontSize: 24, color: novedades[index]['VALOR2'] >= 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        isThreeLine: false,
                                      ),
                                  ),
                                  ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  ),
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
                        Icons.arrow_circle_left_outlined, // Cambia por el icono que necesites
                        color: Colors.white,
                        size: 50,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                      color: Colors.white,
                      icon: _notificationCount > 0
                          ? badges.Badge(
                              badgeContent: Text(
                                '$_notificationCount',
                                style: TextStyle(color: Colors.white),
                              ),
                              child: const Icon(
                                Icons.circle_notifications,
                                color: Colors.white,
                                size: 45,
                              ),
                            )
                          : const Icon(
                              Icons.circle_notifications,
                              color: Colors.white,
                              size: 45,
                            ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/suministrosr');// Acción al presionar el icono derecho
                      },
                    ),
                  ),
                
              ],
            ),
          ),
        ],
      ),
    );
    }
    );
  }

}
