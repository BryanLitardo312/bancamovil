import 'package:bancamovil/chat/claude_api_service.dart';
import 'package:bancamovil/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatProvider with ChangeNotifier {
  final _apiService = ClaudeApiService(apiKey:dotenv.get('ANTHROPIC_API_KEY'));
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    final userMessage = Message(content: content,isUser:true,timestamp: DateTime.now()
    );
    _messages.add(userMessage);
    notifyListeners();
    _isLoading=true;
    try{
      final response = await _apiService.sendMessage(content);
      // response from AI
      final responseMessage = Message(content: response,isUser: false,timestamp:DateTime.now()
      );
      //add to chat
      _messages.add(responseMessage);
    }
    catch(e){
      final errorMessage = Message(
        content: 'Disculpa, indentifiqué un error.. $e',
        isUser: false,
        timestamp: DateTime.now()
        );
        _messages.add(errorMessage);
    }
    finally{
      _isLoading=false;
      notifyListeners();
    }

  }
}
