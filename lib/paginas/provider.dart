import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import 'package:intl/intl.dart';



class Datamodel extends ChangeNotifier {
  String? nombreUsuario;
  String? apellidoUsuario;
  String? encargado;
  String? genero;
  String? tipo;
  String? nombreEstacion;
  String? bodegaEstacion;
  int coordinador_id = 0;
  String? coordinadorname;
  String? coordinadorsexo;
  String? correoInicio;
  String? saldoneto;
  Map<String, double> acumuladosPorNombre = {};
  Map<String, double> acumulados = {};
  String categoriaFiltrar = '+';
  String categoria2Filtrar = '-';  // Cambia esto para filtrar por otra categoría
  double sumaAcumulada2 = 0.0;
  double restaAcumulada2 = 0.0;
  Stream<List<Map<String, dynamic>>> novedadesStream = Stream.empty();
  List<Map<String, dynamic>> novedadesList = [];
  List<FlSpot> flSpotData = [];
  List<FlSpot> flSpotDatames = [];
  List<String> titles = [];
  List<String> estaciones = [];
  final List<FlSpot> data = [];
  final List<FlSpot> datames = [];
  //List<dynamic> historial = [];
  late List<dynamic> solicitudes_suministros = [];
  late List<dynamic> solicitudes_novedades = [];
  final TextEditingController noteController = TextEditingController();
  String? userId;
  Map<String, dynamic> userData = {};
  String? genero_list;
  List<String> opcionesGenero = ['Masculino', 'Femenino'];
  List<String> opcionesCargo = ['Gerente', 'Soporte'];
  bool isLoading = false;
  bool isActive = false;

  void clearData() {
    userId = null;
    userData.clear();
    solicitudes_suministros.clear();
    notifyListeners(); // Notifica a los widgets que el estado ha cambiado
  }


  Datamodel() {
    _initializeAndProcessStream();
  }

  void cambiarGenero(String? nuevoGenero) {
    if (nuevoGenero != null) {
      genero_list = nuevoGenero;
      notifyListeners();
    }
  }

  void cambiarswitch(bool nuevovalor) {
    isActive = nuevovalor;
    notifyListeners();
  }

  Future<void> actualizarNombreUsuario(String nuevoNombre,String nuevoApellido) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user != null) {
    final correoInicio = user.email;
    
    final type = await supabase
      .from('Directorio')
      .select("User")
      .eq("Correo EDS", correoInicio!)
      .single();
    final tipo=type["User"];
    
    if (tipo =='usuario'){
      
      final bodega_Estacion = await supabase
        .from('Directorio')
        .select("BOD")
        .eq("Correo EDS", correoInicio)
        .single();
      final bodegaEstacion = bodega_Estacion["BOD"];
    
      await supabase
        .from('Contactos')
        .update({'nombre': nuevoNombre})
        .eq('BOD', bodegaEstacion);
      
      await supabase
        .from('Contactos')
        .update({'apellidos': nuevoApellido})
        .eq('BOD', bodegaEstacion);
      nombreUsuario = nuevoNombre;
      apellidoUsuario = nuevoApellido;
      notifyListeners();

      if (genero_list=='Masculino'){
        await supabase
          .from('Contactos')
          .update({'Sexo': 'M'})
          .eq('BOD', bodegaEstacion);
      } if (genero_list=='Femenino'){
        await supabase
          .from('Contactos')
          .update({'Sexo': 'F'})
          .eq('BOD', bodegaEstacion);
      }

    } if (tipo=='admin' || tipo=='coordinador') {

      final idGerencial = await supabase
        .from('Directorio')
        .select("ID_user")
        .eq("Correo EDS", correoInicio)
        .single();
      final idgerencial=idGerencial['ID_user'];
      
      await supabase
        .from('ContactosTM')
        .update({'nombre': nuevoNombre})
        .eq('id_user', idgerencial);

      await supabase
        .from('ContactosTM')
        .update({'apellido': nuevoApellido})
        .eq('id_user', idgerencial);
      
      nombreUsuario = nuevoNombre;
      apellidoUsuario = nuevoApellido;
      notifyListeners();
      if (genero_list=='Masculino'){
        await supabase
          .from('ContactosTM')
          .update({'Sexo': 'M'})
          .eq('id_user', idgerencial);
      } if (genero_list=='Femenino'){
        await supabase
          .from('ContactosTM')
          .update({'Sexo': 'F'})
          .eq('id_user', idgerencial);
      }
    }
    }
  }

  void processData(docs,user){
    acumuladosPorNombre.clear();
      sumaAcumulada2 = 0.0;
      restaAcumulada2 = 0.0;
      flSpotData.clear();
      flSpotDatames.clear();
      titles.clear();
      data.clear();
      datames.clear();
      
      final Map<String, double> totalPorFecha = {}; // Mapa para almacenar el total por fecha
      double acumulado = 0;
      for (var doc in docs) {
        try {
          final fecha = doc['FECHA'] as String; // Asegúrate de que FECHA es un String
          final value = double.tryParse(doc['VALOR2'].toString()) ?? 0.0;
          //Valores totales por fecha
          acumulado += value;
          totalPorFecha[fecha] = acumulado;

          //Valores totales por signo
          double valor2 = doc['VALOR2'] is int
            ? (doc['VALOR2'] as int).toDouble()
            : doc['VALOR2'] as double;
          if (doc['SIGNO'] == categoriaFiltrar) {
            sumaAcumulada2 += valor2;
            //print('Suma Acumulada: $sumaAcumulada'); // Imprimir la suma acumulada
          } else if (doc['SIGNO'] == categoria2Filtrar) {
            restaAcumulada2 += valor2;
            //print('Resta Acumulada: $restaAcumulada'); // Imprimir la resta acumulada
          }

          final String nombre;

          if (user == 'usuario') {
            nombre = doc['NOMBRE'] as String;
          } else {
            nombre = doc['ESTACION'] as String;
          }
          //final nombre = doc['ESTACION'] as String;
          final valor = double.tryParse(doc['VALOR2'].toString()) ?? 0.0; // Obtener el valor

          // Acumular el valor por nombre
          if (acumuladosPorNombre.containsKey(nombre)) {
            acumuladosPorNombre[nombre] = acumuladosPorNombre[nombre]! + valor;
          } else {
            acumuladosPorNombre[nombre] = valor;
          }
          titles = acumuladosPorNombre.keys.toList();

        } catch (e) {
          print('Error al procesar los datos: $e');
        }
      }
      totalPorFecha.forEach((fecha, total) {
        try {
          //final dia = int.parse(fecha.split('/')[1]);
          final fechaObj = DateFormat('MM/dd/yyyy').parse(fecha);
          //final diaMes = DateFormat('dd/MM').format(fechaObj);
          data.add(FlSpot(fechaObj.millisecondsSinceEpoch.toDouble(), total*(-1)));
          //print(data);
        } catch (e) {
          //print('Error al convertir la fecha: $fecha');
          print('Error: $e');
        }
      });

      // Ordena los datos por el eje X (fecha)
      data.sort((a, b) => a.x.compareTo(b.x));
      // Actualiza el estado con los datos procesados
      flSpotData = data;
      saldoneto=flSpotData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b).toStringAsFixed(2);


      totalPorFecha.forEach((fecha, total) {
        try {
          final mes = int.parse(fecha.split('/')[0]);
          datames.add(FlSpot(mes.toDouble(), total));
        } catch (e) {
          //print('Error al convertir la fecha: $fecha');
          print('Error: $e');
        }
      });
      // Ordena los datos por el eje X (fecha)
      datames.sort((c, d) => c.x.compareTo(d.x));
      // Actualiza el estado con los datos procesados
      flSpotDatames = datames;
      
      notifyListeners();
    }
  

  void _initializeAndProcessStream() async{
    isLoading = true;
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user != null) {
      final correoInicio = user.email;
      final typeResponse = await supabase
          .from('Directorio')
          .select("User")
          .eq("Correo EDS", correoInicio!)
          .single();
      tipo=typeResponse['User'];
      if (tipo == 'usuario') {
        final userResponse = await supabase
        .from('Directorio')
        .select("BOD")
        .eq("Correo EDS", correoInicio)
        .single();
        bodegaEstacion = userResponse['BOD'];

        final userName = await supabase
            .from('Directorio')
            .select("EESS")
            .eq("Correo EDS", correoInicio)
            .single();
        nombreEstacion = userName['EESS'];

        
        final encargadoResponse = await supabase
            .from('Contactos')
            .select("nombre")
            .eq("BOD", bodegaEstacion!)
            .single();
        encargado = encargadoResponse['nombre'];
        
        final generoResponse = await supabase
            .from('Contactos')
            .select("Sexo")
            .eq("BOD", userResponse['BOD'])
            .single();
        genero = generoResponse['Sexo']; // Asigna el valor a la propiedad
        
        final suministrosStream = await supabase
          .from('Suministros')
          .stream(primaryKey: ['requests']) // Cambia 'id' por la clave primaria de la tabla
          .eq("bodega", bodegaEstacion!)
          .order('created_at', ascending: false);
        suministrosStream.listen((data) {
          solicitudes_suministros = data; // Asignación directa
          notifyListeners(); 
           // Notifica a los widgets que el estado ha cambiado
        });
        
        final novedadesqStream = await supabase
          .from('Novedades')
          .stream(primaryKey: ['id']) // Cambia 'id' por la clave primaria de la tabla
          .eq("BODEGA", bodegaEstacion!)
          .order('created_at', ascending: false);
        novedadesqStream.listen((data) {
          solicitudes_novedades=data;
          notifyListeners(); 
           // Notifica a los widgets que el estado ha cambiado
        });
        

        novedadesStream = await supabase
          .from('EECC')
          .stream(primaryKey: ['No'])
          .eq('BODEGA', bodegaEstacion!);

        novedadesStream.listen((docs) {
          processData(docs,tipo);
        }
        );
      } else if (tipo == 'coordinador') {
        final id = await supabase
            .from("Directorio")
            .select("ID_user")
            .eq("Correo EDS", correoInicio)
            .single();
        coordinador_id = id['ID_user'];
        
        final nombre = await supabase
            .from("ContactosTM")
            .select("nombre")
            .eq("id_user", coordinador_id)
            .single();
        encargado=nombre["nombre"];

        final gen = await supabase
            .from("ContactosTM")
            .select("Sexo")
            .eq("id_user", coordinador_id)
            .single();
        genero=gen["Sexo"];

        final bodegas = await supabase
            .from('Zonas')
            .select("BOD")
            .eq("id_user", coordinador_id);
        estaciones = bodegas.map((e) => e['BOD'].toString()).toList();

        final suministrosStream = supabase
          .from('Suministros')
          .stream(primaryKey: ['requests']) // Cambia 'id' por la clave primaria de la tabla
          .inFilter("bodega", estaciones)
          .order('created_at', ascending: false);
        suministrosStream.listen((data) {
          solicitudes_suministros = data; // Asignación directa
          notifyListeners(); 
           // Notifica a los widgets que el estado ha cambiado
        });
        
        final novedadesqStream = supabase
          .from('Novedades')
          .stream(primaryKey: ['id']) // Cambia 'id' por la clave primaria de la tabla
          .inFilter("BODEGA", estaciones)
          .order('created_at', ascending: false);
        novedadesqStream.listen((data) {
          solicitudes_novedades=data;
          notifyListeners(); 
           // Notifica a los widgets que el estado ha cambiado
        });
        
        novedadesStream = supabase
          .from('EECC')
          .stream(primaryKey: ['No'])
          .inFilter('BODEGA', estaciones);
        
        novedadesStream.listen((docs) {
          processData(docs,tipo);
        }
        );
      } else if (tipo == 'admin') {
        final id = await supabase
            .from("Directorio")
            .select("ID_user")
            .eq("Correo EDS", correoInicio)
            .single();
        coordinador_id = id['ID_user'];
        
        final nombre = await supabase
            .from("ContactosTM")
            .select("nombre")
            .eq("id_user", coordinador_id)
            .single();
        encargado=nombre["nombre"];
        

        final gen = await supabase
            .from("ContactosTM")
            .select("Sexo")
            .eq("id_user", coordinador_id)
            .single();
        genero=gen["Sexo"];

       final bodegas = await supabase
        .from('Zonas')
        .select("BOD")
        .neq("BOD", "NA")  // Valores únicos
        .order("BOD");
        estaciones = bodegas.map((e) => e['BOD'].toString()).toList();
        //print(estaciones);

        final suministrosStream = supabase
          .from('Suministros')
          .stream(primaryKey: ['requests']) // Cambia 'id' por la clave primaria de la tabla
          .inFilter("bodega", estaciones)
          .order('created_at', ascending: false);
        suministrosStream.listen((data) {
          solicitudes_suministros = data; // Asignación directa
          notifyListeners(); 
           // Notifica a los widgets que el estado ha cambiado
        });
        
        final novedadesqStream = supabase
          .from('Novedades')
          .stream(primaryKey: ['id']) // Cambia 'id' por la clave primaria de la tabla
          .inFilter("BODEGA", estaciones)
          .order('created_at', ascending: false);
        novedadesqStream.listen((data) {
          solicitudes_novedades=data;
          notifyListeners(); 
           // Notifica a los widgets que el estado ha cambiado
        });
        
        novedadesStream = supabase
          .from('EECC')
          .stream(primaryKey: ['No'])
          .inFilter('BODEGA', estaciones);
        
        novedadesStream.listen((docs) {
          processData(docs,tipo);
        }
        );
      } else {
        print('No hay usuario autenticado');
      }
    }
    isLoading = false;
  }
}