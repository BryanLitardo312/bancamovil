import 'package:bancamovil/chat/messages.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build (BuildContext context){
    return Align(
      alignment:message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: message.isUser ? const EdgeInsets.only(left: 90, right: 30, bottom: 20,top:20) : const EdgeInsets.only(left: 30, right: 90, bottom: 20, top: 20),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.grey[900] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message.content,
          style: TextStyle(color: message.isUser ? Colors.white : Colors.black)
        ),
      ),
      );
  }
}