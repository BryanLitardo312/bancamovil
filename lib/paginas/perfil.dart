import 'package:bancamovil/componentes/dropdown.dart';
import 'package:bancamovil/componentes/textfield.dart';
import 'package:flutter/material.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/paginas/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _contactoController;
  late TextEditingController _nombrepromotorController;
  late TextEditingController _apellidopromotorController;
  late TextEditingController _contactopromotorController;
  
  @override
  void initState() {
    super.initState();
    //final value = Provider.of<Datamodel>(context, listen: false);
    _nombreController = TextEditingController();
    _apellidoController = TextEditingController();
    _contactoController = TextEditingController();
    _nombrepromotorController = TextEditingController();
    _apellidopromotorController = TextEditingController();
    _contactopromotorController = TextEditingController();// Inicializa con el valor de la base de datos
  }

  @override
  void dispose() {
    _nombreController.clear();
    _apellidoController.clear();
    _contactoController.clear();
    _nombrepromotorController.clear();
    _apellidopromotorController.clear();
    _contactopromotorController.clear(); // Limpia el controlador al salir
    super.dispose();
  }

  void _actualizarNombre() async {
    final nuevoNombre = _nombreController.text.trim();
    final nuevoApellido = _apellidoController.text.trim();
    if (nuevoNombre.isEmpty || nuevoApellido.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Campo vacío',style:TextStyle(fontSize: 18)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final value = Provider.of<Datamodel>(context, listen: false);
      await value.actualizarNombreUsuario(nuevoNombre,nuevoApellido);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nombre actualizado',style:TextStyle(fontSize: 18),),
          backgroundColor: Colors.green,
        ),
      );
      _nombreController.clear();
      _apellidoController.clear();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar el nombre: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;
    //final value = Provider.of<Datamodel>(context, listen: false);
    return Consumer<Datamodel>(
      builder:(context,value,child)=> Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Actualización',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black),),
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
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(value.genero == 'M' ? 'lib/imagenes/hombre2.png' : 'lib/imagenes/mujer.png',),
                      ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      TextfieldPerfil(controller: _nombreController, hintText: 'Nombre', icon: Icons.person),
                      TextfieldPerfil(controller: _apellidoController, hintText: 'Apellido Paterno', icon: Icons.person),
                      TextfieldPerfil(controller: _contactoController, hintText: 'Contacto', icon: Icons.call),
                      //const SizedBox(height: 30),
                      DropDownGenero(),
                      DropDownCargo(),
                      const SizedBox(height: 50),
                      const Text('Datelles del negocio',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),),
                      const SizedBox(height: 5),
                      Divider(
                        height: 1.0,       // Altura del espacio que ocupa el Divider (no el grosor de la línea)
                        thickness: 2.0,    // Grosor de la línea divisoria
                        color: Colors.grey[700], // Color de la línea
                        indent: 30.0,      // Espacio de sangría a la izquierda
                        endIndent: 30.0,   // Espacio de sangría a la derecha
                      ),
                      const SizedBox(height: 30),
                      DropDownCategoria(),
                      DropDownTMPista(),
                      DropDownTMTienda(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Tienes soporte?',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey[900]),),
                          const SizedBox(width:15),
                          Switch(
                            value: value.isActive, // Valor actual (true/false)
                            onChanged: (bool nuevovalor) {value.cambiarswitch(nuevovalor);
                            },
                            // Personalización opcional:
                            activeColor: Color.fromARGB(255, 40, 125, 43),  // Color cuando está activo
                            inactiveThumbColor: Colors.grey, // Color del "pulgar" cuando está inactivo
                            inactiveTrackColor: Colors.grey[300], // Color del fondo cuando está inactivo
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      value.isActive == true ? 
                      Column(
                        children: [
                          TextfieldPerfil(controller: _nombrepromotorController, hintText: 'Nombre', icon: Icons.person),
                          TextfieldPerfil(controller: _apellidopromotorController, hintText: 'Apellido Paterno', icon: Icons.person),
                          TextfieldPerfil(controller: _contactopromotorController, hintText: 'Contacto', icon: Icons.call),
                        ],
                      ): SizedBox.shrink(),

                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _actualizarNombre,
                              icon: const Icon(Icons.save,size:30),
                              label: const Text('Guardar',style:TextStyle(fontSize: 19)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 40, 125, 43),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ), 
              ],
            ),
          ),
      ),
    );
  }
}