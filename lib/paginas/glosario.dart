//import 'dart:convert';
import 'package:bancamovil/models/suministros.dart';
import 'package:flutter/material.dart';
//import 'package:banca/componentes/sliver.dart';
import 'package:bancamovil/componentes/button_login.dart';
import 'package:bancamovil/models/database.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;


class Glosario extends StatefulWidget {
  const Glosario ({super.key});

  @override
  State<Glosario> createState() => _GlosarioState();

}

class _GlosarioState extends State<Glosario> {
  final suministrosDB = SuministrosBanco();
  int _notificationCount = 0;
  late List<Map<String, dynamic>> seleccionados=[];
  
  
  void _submitForm() {
    seleccionados = _items.where((item) => item['value'] == true).toList();
    final valor = Provider.of<Datamodel>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          'Confirmación',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        content: const Text(
          'La solicitud ha finalizado',
          style:TextStyle(
            fontSize: 17,
            color: Colors.white
            )
          ),
        
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              seleccionados.clear();
            },
            child: const Text(
              'Cancelar',
              style:TextStyle(
                color:Colors.white,
                fontSize: 18
                )
              ),
            ),
            TextButton(
              onPressed: () async {
                if (seleccionados.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No hay ítems seleccionados para enviar.',style: TextStyle(fontSize: 18),)),
                  );
                  Navigator.pop(context);
                  return;
                }
                final List<String> titles = seleccionados.map((item) => item['title'] as String).toList();
                final newNote = Suministros(
                  //id: DateTime.now().millisecondsSinceEpoch, // O proporciona un ID si es necesario
                  bodega: valor.bodegaEstacion.toString(), // Proporciona un valor adecuado
                  estacion: valor.nombreEstacion.toString(), // Proporciona un valor adecuado
                  detalle: titles.toString(), //noteController.text,
                );
                try {
                  print('Datos a enviar: ${seleccionados[0]['title']}');
                  await suministrosDB.createForm(newNote);
                  
                  Navigator.pop(context);
                  setState(() {
                    _notificationCount++;
                    seleccionados.clear();
                    _items = _items.map((item) => {...item, 'value': false}).toList();
                     // Incrementar contador
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Solicitud enviada correctamente',style: TextStyle(fontSize: 18),),backgroundColor: Colors.green),
                  );
                  //noteController.clear();
                } catch (e) {
                  // Maneja el error si es necesario
                  print('Error al crear el formulario: $e');
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

  List<Map<String, dynamic>> _items = [
    {'title': 'Guías', 'subtitle': 'Paquete x40 unidades', 'value': false},
    {'title': 'Papeletas de depósito', 'subtitle': 'Paquete x40 unidades', 'value': false},
    {'title': 'Fundas de Billetes', 'subtitle': 'Paquete x60 unidades', 'value': false},
    {'title': 'Fundas de Monedas', 'subtitle': 'Paquete x60 unidades', 'value': false},
  ];
  
  
  @override
  Widget build(BuildContext context) {
    final valor = Provider.of<Datamodel>(context, listen: false);
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'lib/imagenes/Portada_Perimetral.jpg', // Reemplaza con la ruta de tu imagen
                width: double.infinity,
                height: screenHeight*0.35, // Ajusta la altura según sea necesario
                fit: BoxFit.cover,
              ),
              SizedBox(height: screenHeight*0.06), // Añadir un espacio entre el Container y el texto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Suministros',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.local_shipping,size:30,color:Colors.grey[900]),
                    ],
                  
                ),
              ),
              SizedBox(height: screenHeight*0.04),
              Column(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    shrinkWrap: true,
                    itemCount: _items.length, // Número de elementos en la lista
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(_items[index]['title'],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(_items[index]['subtitle'],style: const TextStyle(fontSize: 15),),
                        value: _items[index]['value'],
                        onChanged: (value) {
                          setState(() {
                            _items[index]['value'] = value!;
                          });
                        },
                        activeColor: Color.fromARGB(255, 14, 97, 136), // Color del checkbox cuando está activo
                        checkColor: Colors.white, // Color de la marca de verificación
                        tileColor: Colors.grey[100],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight*0.06),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: ButtonLogin2(
                  onTap: valor.tipo == 'usuario' ? _submitForm : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Servicio no disponible',style: TextStyle(fontSize: 18),)),
                    );
                  },
                  text: 'ENVIAR SOLICITUD',
                  icon: Icons.how_to_vote,
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
}