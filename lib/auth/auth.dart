import 'package:supabase_flutter/supabase_flutter.dart';
//import 'package:bancamovil/paginas/login_page.dart';
import 'package:flutter/material.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }
  Future<AuthResponse?> signInWithPassword({required String email, required String password}) async {
    try {
      AuthResponse authResponse =
      await supabase.auth.signInWithPassword(email: email, password: password);
      return authResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<AuthResponse?> signUp({required String email, required String password}) async {
    try {
      AuthResponse authResponse =
      await supabase.auth.signUp(email: email, password: password);
      return authResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await supabase.auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}