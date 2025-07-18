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
      body: SafeArea(
        child: Column(
          children:[
            Expanded(
              child: Consumer<ChatProvider>(
                builder:(context,chatProvider,child){
                if (chatProvider.messages.isEmpty){
                  return const Center(
                    child: Text('Iniciar Conversación..'),
                    );
                }
                return ListView.builder(
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context,index){
                    final message = chatProvider.messages[index];
                    return Text(message.content);
                  },
                );
              },
            ),
            ),
            Row(
              children:[
                Expanded(
                  child: TextField(controller:_controller),
                ),
                IconButton(
                  onPressed: (){
                    if(_controller.text.isNotEmpty){
                      final chatProvider = context.read<ChatProvider>();
                      chatProvider.sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  icon:const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


