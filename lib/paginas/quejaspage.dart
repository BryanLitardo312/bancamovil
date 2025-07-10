import 'package:bancamovil/models/sugerencias.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/models/database.dart';

class QuejasPage extends StatefulWidget {
  const QuejasPage({Key? key}) : super(key: key);

  @override
  State<QuejasPage> createState() => _QuejasPageState();
}

class _QuejasPageState extends State<QuejasPage> {
  final sugerencias = SugerenciasUser();
  final TextEditingController _comentarioController = TextEditingController();
  String mensaje = '';

  void enviarQueja() {
    final valor = Provider.of<Datamodel>(context, listen: false);
    final comentario = _comentarioController.text.trim();

    if (comentario.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Su comentario está vacío'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          'Confirmación',
          style: TextStyle(color: Colors.white)
          ),
        content: const Text(
          'Su comentario se revisará en breve',
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
                final newNote = Sugerencias(
                  //id: DateTime.now().millisecondsSinceEpoch, // O proporciona un ID si es necesario
                  BOD: valor.bodegaEstacion?? 'No disponible',
                  EESS: valor.nombreEstacion?? 'No disponible',
                  mensaje: comentario,
                  
                );
                try {
                  //print('Datos a enviar: ${item['NOMBRE']}');
                  await sugerencias.createForm(newNote);
                  Navigator.pop(context);
                  setState(() {
                    //_quejas.add(comentario); // Agrega la queja a la lista
                    mensaje='¡Gracias, tu opinión nos fortalece!';
                    _comentarioController.clear();
                    FocusScope.of(context).unfocus();
                  });
                  /*ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Comentario enviado',style: TextStyle(fontSize: 18),),backgroundColor: Colors.green),
                  );*/
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                    'lib/imagenes/Alborada.jpeg', // Reemplaza con la ruta de tu imagen
                    width: double.infinity,
                    height: screenHeight*0.35, // Ajusta la altura según sea necesario
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: screenHeight*0.08),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sugerencias',
                            style: TextStyle(fontSize: 25, color:Colors.white,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10,),
                          Icon(Icons.comment_bank_rounded,color:Colors.white,size:30)
                        ],
                      ),
                      SizedBox(height: screenHeight*0.06),
                      TextField(
                        maxLength: 100,
                        controller: _comentarioController,
                        maxLines: 5,
                        
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[800],
                          counterStyle: TextStyle(color: Colors.white,fontSize:18),
                          hintText: 'Escribe tu comentario aquí...',
                          hintStyle: TextStyle(color:Colors.white,fontSize: 16),
                          border: OutlineInputBorder(
                            //borderSide: BorderSide(color: Colors.white, width: 4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: screenHeight*0.03),
                      //ButtonLogin(onTap: (){}, text: 'Enviar', icon: Icons.send),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: enviarQueja,
                                icon: const Icon(Icons.send, size: 30),
                                label: const Text('Compartir', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          
                        ],
                      ),
                      SizedBox(height: screenHeight*0.04),
                      Text(
                        mensaje.toString(),
                        style: const TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                
              ],
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
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(Icons.arrow_circle_left,color:Colors.black,size: 50,),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
      );
  }
}