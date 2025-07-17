import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({this.onExit, super.key});
  final VoidCallback? onExit;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

