import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/paginas/provider.dart';

class DropDownGenero extends StatefulWidget {

  const DropDownGenero({
    super.key,
  });

  @override
  _DropDownGeneroState createState() => _DropDownGeneroState();
}

class _DropDownGeneroState extends State<DropDownGenero> {
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
        leadingIcon: Icon(Icons.person, color: Colors.grey[800]),
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



class DropDownCargo extends StatefulWidget {

  const DropDownCargo({
    super.key,
  });

  @override
  _DropDownCargoState createState() => _DropDownCargoState();
}

class _DropDownCargoState extends State<DropDownCargo> {
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
        leadingIcon: Icon(Icons.person, color: Colors.grey[800]),
        label: Text('Cargo Atimasa',style: TextStyle(fontSize: 16,color: Colors.grey[700],fontWeight: FontWeight.bold,)),
        //initialSelection: value.genero_list,
        onSelected: (String? cargo) {
          value.cambiarCargo(cargo);
        },
        dropdownMenuEntries: value.opcionesCargo.map((String cargo) {
          return DropdownMenuEntry<String>(
            value: cargo,
            label: cargo,
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


class DropDownCargoAdmin extends StatefulWidget {

  const DropDownCargoAdmin({
    super.key,
  });

  @override
  _DropDownCargoAdminState createState() => _DropDownCargoAdminState();
}

class _DropDownCargoAdminState extends State<DropDownCargoAdmin> {
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
        leadingIcon: Icon(Icons.person, color: Colors.grey[800]),
        label: Text('Departamento',style: TextStyle(fontSize: 16,color: Colors.grey[700],fontWeight: FontWeight.bold,)),
        //initialSelection: value.genero_list,
        onSelected: (String? cargo) {
          value.cambiarCargoAdmin(cargo);
        },
        dropdownMenuEntries: value.opcionesCargoAdmin.map((String cargo) {
          return DropdownMenuEntry<String>(
            value: cargo,
            label: cargo,
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



class DropDownCategoria extends StatefulWidget {

  const DropDownCategoria({
    super.key,
  });

  @override
  _DropDownCategoriaState createState() => _DropDownCategoriaState();
}

class _DropDownCategoriaState extends State<DropDownCategoria> {
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
        leadingIcon: Icon(Icons.person, color: Colors.grey[800]),
        label: Text('Categoría',style: TextStyle(fontSize: 16,color: Colors.grey[700],fontWeight: FontWeight.bold,)),
        //initialSelection: value.genero_list,
        onSelected: (String? categoria) {
          value.cambiarCategoria(categoria);
        },
        dropdownMenuEntries: value.opcionesCategoria.map((String categoria) {
          return DropdownMenuEntry<String>(
            value: categoria,
            label: categoria,
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

class DropDownTMPista extends StatefulWidget {

  const DropDownTMPista({
    super.key,
  });

  @override
  _DropDownTMPistaState createState() => _DropDownTMPistaState();
}

class _DropDownTMPistaState extends State<DropDownTMPista> {
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
        leadingIcon: Icon(Icons.person, color: Colors.grey[800]),
        label: Text('TM Pista',style: TextStyle(fontSize: 16,color: Colors.grey[700],fontWeight: FontWeight.bold,)),
        //initialSelection: value.genero_list,
        onSelected: (String? pista) {
          value.cambiarpista(pista);
        },
        dropdownMenuEntries: value.opcionespista.map((String pista) {
          return DropdownMenuEntry<String>(
            value: pista,
            label: pista,
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


class DropDownTMTienda extends StatefulWidget {

  const DropDownTMTienda({
    super.key,
  });

  @override
  _DropDownTMTiendaState createState() => _DropDownTMTiendaState();
}

class _DropDownTMTiendaState extends State<DropDownTMTienda> {
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
        leadingIcon: Icon(Icons.person, color: Colors.grey[800]),
        label: Text('TM Tienda',style: TextStyle(fontSize: 16,color: Colors.grey[700],fontWeight: FontWeight.bold,)),
        //initialSelection: value.genero_list,
        onSelected: (String? tienda) {
          value.cambiartienda(tienda);
        },
        dropdownMenuEntries: value.opcionestienda.map((String tienda) {
          return DropdownMenuEntry<String>(
            value: tienda,
            label: tienda,
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