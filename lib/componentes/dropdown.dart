import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/paginas/provider.dart';

class DropDawnGenero extends StatefulWidget {

  const DropDawnGenero({
    super.key,
  });

  @override
  _DropDawnGeneroState createState() => _DropDawnGeneroState();
}

class _DropDawnGeneroState extends State<DropDawnGenero> {
  @override
    Widget build(BuildContext context) {
      final value = Provider.of<Datamodel>(context, listen: false);
      return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<String>(
        //width: 300, // Ancho personalizado
        width: constraints.maxWidth,
        menuStyle: MenuStyle(
          minimumSize: MaterialStateProperty.all(
            Size(constraints.maxWidth, 0), // Ancho completo para el menú
          ),
          maximumSize: MaterialStateProperty.all(
            Size(constraints.maxWidth, double.infinity),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
          elevation: MaterialStateProperty.all(5),
        ),
        textStyle: TextStyle(color: Colors.grey[900], fontSize: 16),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,           // Sin borde normal
          enabledBorder: InputBorder.none,    // Sin borde cuando está habilitado
          focusedBorder: InputBorder.none,
        ),
        leadingIcon: Icon(Icons.person, color: Colors.grey[900]),
        label: Text('Género',style: TextStyle(fontSize: 16, color: Colors.grey[700],fontWeight: FontWeight.bold,),),
        //initialSelection: value.genero_list,
        onSelected: (String? genero) {
          value.cambiarGenero(genero);
        },
        dropdownMenuEntries: value.opcionesGenero.map((String genero) {
          return DropdownMenuEntry<String>(
            value: genero,
            label: genero,
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 16),
              ),
              alignment: Alignment.center, // Centrar el texto
            ),
          );
        }).toList(),
      );
      }
      );
    }
}



class DropDawnCargo extends StatefulWidget {

  const DropDawnCargo({
    super.key,
  });

  @override
  _DropDawnCargoState createState() => _DropDawnCargoState();
}

class _DropDawnCargoState extends State<DropDawnCargo> {
  @override
    Widget build(BuildContext context) {
      final value = Provider.of<Datamodel>(context, listen: false);
      return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<String>(
        width: constraints.maxWidth,
        menuStyle: MenuStyle(
          minimumSize: MaterialStateProperty.all(
            Size(constraints.maxWidth, 0), // Ancho completo para el menú
          ),
          maximumSize: MaterialStateProperty.all(
            Size(constraints.maxWidth, double.infinity),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
          elevation: MaterialStateProperty.all(5),
        ),
        textStyle: TextStyle(color: Colors.grey[900], fontSize: 16),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,           // Sin borde normal
          enabledBorder: InputBorder.none,    // Sin borde cuando está habilitado
          focusedBorder: InputBorder.none,
        ),
        leadingIcon: Icon(Icons.person, color: Colors.grey[900]),
        label: Text('Cargo',style: TextStyle(fontSize: 16,color: Colors.grey[700],fontWeight: FontWeight.bold,)),
        //initialSelection: value.genero_list,
        onSelected: (String? genero) {
          value.cambiarGenero(genero);
        },
        dropdownMenuEntries: value.opcionesGenero.map((String genero) {
          return DropdownMenuEntry<String>(
            value: genero,
            label: genero,
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 16),
              ),
              alignment: Alignment.center, // Centrar el texto
            ),
          );
        }).toList(),
      );
      }
      );
    }
}