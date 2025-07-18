import 'package:bancamovil/chat/bubble.dart';
import 'package:bancamovil/chat/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  //final VoidCallback? onExit;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  final _controller = TextEditingController();
  
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: const Text('Chat AI',style:TextStyle(color:Colors.white)),
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
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children:[
            Expanded(
              child: Consumer<ChatProvider>(
                builder:(context,chatProvider,child){
                if (chatProvider.messages.isEmpty){
                  return const Center(
                    child: Text('Iniciar conversación...',style: TextStyle(color:Colors.white,fontSize: 20),),
                    );
                }
                return ListView.builder(
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context,index){
                    final message = chatProvider.messages[index];
                    return ChatBubble(message:message);
                  },
                );
              },
            ),
            ),
            Consumer<ChatProvider>(
              builder:(context,chatProvider,child){
                if (chatProvider.isLoading){
                  return const CircularProgressIndicator();
                }
                return const SizedBox();
              }
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:25,horizontal:20),
              child: Row(
                children:[
                  Expanded(
                    child: TextField(
                      controller:_controller,
                      decoration: InputDecoration(
                        hintText: 'Escriba aquí...',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                      keyboardType: TextInputType.text, // Tipo de teclado
                      //textCapitalization: TextCapitalization.words, // Capitalización
                      style: TextStyle(fontSize: 15,color:Colors.white,overflow: TextOverflow.ellipsis,), // Estilo del texto
                      textAlign: TextAlign.start, // Alineación del texto
                      //maxLength: 200,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      if(_controller.text.isNotEmpty){
                        final chatProvider = context.read<ChatProvider>();
                        chatProvider.sendMessage(_controller.text);
                        _controller.clear();
                      }
                    },
                    icon:const Icon(Icons.send_rounded,color:Colors.white,size:30),
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


