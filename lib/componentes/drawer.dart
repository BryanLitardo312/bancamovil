import 'package:bancamovil/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:bancamovil/paginas/login_page.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final AuthService authService = AuthService();
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'lib/imagenes/primax_logo.png',
                  //color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Colors.grey[900],
                  thickness: 4,
                ),
              ),   
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home, color: Colors.white,size:30),
                  title: const Text('Inicio', style: TextStyle(color: Colors.white,fontSize: 17)),
                  //selected: _currentIndex == 1,
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/home');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.white,size:30),
                  title: const Text('Perfil', style: TextStyle(color: Colors.white,fontSize: 17)),
                  //selected: _currentIndex == 2,
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/perfil');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.white,size:30),
                  title: const Text('Suministros', style: TextStyle(color: Colors.white,fontSize: 17)),
                  //selected: _currentIndex == 1,
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/glosario');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.account_balance, color: Colors.white,size:30),
                  title: const Text('Novedades', style: TextStyle(color: Colors.white,fontSize: 17)),
                  //selected: _currentIndex == 2,
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/busqueda');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.bar_chart, color: Colors.white,size:30),
                  title: const Text('Analítica', style: TextStyle(color: Colors.white,fontSize: 17)),
                  //selected: _currentIndex == 2,
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/data');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.comment_bank_rounded, color: Colors.white,size:30),
                  title: const Text('Sugerencias', style: TextStyle(color: Colors.white,fontSize: 17)),
                  //selected: _currentIndex == 2,
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/quejas');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0,bottom: 25.0),
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.white,size:30),
              title: Text('Salir', style: TextStyle(color: Colors.white,fontSize: 17)),
              //selected: _currentIndex == 0,
              onTap: () async {
              //await authService.signOut(context);
              await Supabase.instance.client.auth.signOut();
              
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Provider.of<Datamodel>(context, listen: false).clearData();
              //print('Sesión actual: ${Supabase.instance.client.auth.currentSession}');
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                //Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}