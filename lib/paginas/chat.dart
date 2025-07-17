import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:bancamovil/config.dart';
import '../../funcionality/State.dart';
import 'package:bancamovil/componentes/core_components.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({this.onExit, super.key});
  final VoidCallback? onExit;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

// Modelos básicos para reemplazar los de flutter_chat_types
class User {
  final String id;
  final String firstName;
  final String? imageUrl;

  const User({
    required this.id,
    required this.firstName,
    this.imageUrl,
  });
}

class Message {
  final String id;
  final User author;
  final String text;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.author,
    required this.text,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class _ChatPageState extends State<ChatPage> {
  bool loading = false;
  final List<Message> _messages = [];
  final User _user = const User(id: 'user', firstName: 'You');
  final User _agent = const User(
    firstName: 'Khanh',
    id: 'agent',
    imageUrl: 'https://services.google.com/fh/files/misc/bunny.jpeg',
  );
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages.add(Message(
      id: const Uuid().v4(),
      author: _agent,
      text: 'Hey there! My name is Khanh. I\'m your assistant, let me know how I can help.',
    ));
    _scrollToBottom();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _addMessage(Message message) {
    setState(() {
      _messages.insert(0, message);
      _scrollToBottom();
    });
  }

  void _handleSendPressed() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final message = Message(
      id: const Uuid().v4(),
      author: _user,
      text: text,
    );

    _messageController.clear();
    _addMessage(message);
    _sendMessageToAgent(text);
  }

  Future<String> askAgent(
      String name, String description, String question) async {
    var query = 'The photo is $name. $description. $question.';

    var endpoint = Uri.https(cloudRunHost, '/ask_gemini', {'query': query});
    var response = await http.get(endpoint);

    if (response.statusCode == 200) {
      var responseText = convert.utf8.decode(response.bodyBytes);
      return responseText.replaceAll(RegExp(r'\*'), '');
    }

    return 'Sorry I can\'t answer that.';
  }

  void _sendMessageToAgent(String message) async {
    setState(() {
      loading = true;
    });

    var text = await askAgent(
      context.read<AppState>().metadata!.name,
      context.read<AppState>().metadata!.description,
      message,
    );

    final textMessage = Message(
      author: _agent,
      id: const Uuid().v4(),
      text: text,
    );

    _addMessage(textMessage);

    setState(() {
      loading = false;
    });
  }

  void _pickSuggestedQuestion(String question) {
    _messageController.text = question;
    _handleSendPressed();
  }

  Widget _buildMessageBubble(Message message) {
    final isMe = message.author.id == _user.id;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Column(
            crossAxisAlignment: 
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Nombre de usuario (si no es el usuario actual)
              if (!isMe)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: Text(
                    message.author.firstName,
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 12.0,
                    ),
                  ),
                ),
              
              // Burbuja de mensaje
              Container(
                decoration: BoxDecoration(
                  color: isMe 
                      ? colorScheme.primary 
                      : colorScheme.surface,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar (si está habilitado)
                    if (!isMe && message.author.imageUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(message.author.imageUrl!),
                          radius: 12.0,
                        ),
                      ),
                    if (!isMe)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: CircleAvatar(
                          backgroundColor: colorScheme.primary,
                          child: Text(
                            message.author.firstName[0].toUpperCase(),
                            style: TextStyle(color: colorScheme.onPrimary),
                          ),
                          radius: 12.0,
                        ),
                      ),
                    
                    // Texto del mensaje
                    Text(
                      message.text,
                      style: TextStyle(
                        color: isMe 
                            ? colorScheme.onPrimary 
                            : colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Hora del mensaje
              Padding(
                padding: const EdgeInsets.only(top: 2.0, right: 8.0, left: 8.0),
                child: Text(
                  _formatTime(message.createdAt),
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // Avatar del agente
          CircleAvatar(
            backgroundImage: NetworkImage(_agent.imageUrl!),
            radius: 12.0,
          ),
          
          // Indicador de typing
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Puntos animados
                _TypingDot(color: colorScheme.onSurface),
                const SizedBox(width: 4.0),
                _TypingDot(color: colorScheme.onSurface, delay: 150),
                const SizedBox(width: 4.0),
                _TypingDot(color: colorScheme.onSurface, delay: 300),
                
                // Texto
                const SizedBox(width: 8.0),
                Text(
                  '${_agent.firstName} está escribiendo...',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    var metadata = context.watch<AppState>().metadata;
    Widget? suggestionsWidget;
    
    if (metadata != null) {
      if (_messages.length == 1) {
        suggestionsWidget = Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: TagCapsule(
            onTap: _pickSuggestedQuestion,
            title: 'Suggested Questions',
            tags: metadata.suggestedQuestions,
          ),
        );
      }
    }

    return Column(
      children: [
        AppBar(
          title: const Text('Chat with AI'),
          actions: (widget.onExit != null)
              ? [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: widget.onExit,
                      icon: const Icon(
                        size: 28,
                        FontAwesomeIcons.circleXmark,
                      ),
                    ),
                  )
                ]
              : [],
        ),
        Expanded(
          child: Column(
            children: [
              // Área de mensajes
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true, // Para mantener la misma lógica que el chat original
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _messages.length + (loading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (loading && index == 0) {
                        return _buildTypingIndicator();
                      }
                      return _buildMessageBubble(_messages[index - (loading ? 1 : 0)]);
                    },
                  ),
                ),
              ),
              
              // Widget de sugerencias (si existe)
              if (suggestionsWidget != null) suggestionsWidget,
              
              // Área de entrada de texto
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Escribe un mensaje...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        onSubmitted: (_) => _handleSendPressed(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary),
                      onPressed: _handleSendPressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget para los puntos animados del typing indicator
class _TypingDot extends StatefulWidget {
  final Color color;
  final int delay;

  const _TypingDot({required this.color, this.delay = 0});

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.delay / 1000,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}