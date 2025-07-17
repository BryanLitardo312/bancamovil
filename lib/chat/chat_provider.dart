import 'package:bancamovil/chat/claude_api_service.dart';
import 'package:bancamovil/chat/messages.dart';
import 'package:flutter/material.dart';

class ChatProvider {
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;
}
