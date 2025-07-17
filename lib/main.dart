import 'package:bancamovil/auth/gate.dart';
//import 'package:bancamovil/paginas/NewPass.dart';
import 'package:bancamovil/paginas/data.dart';
import 'package:bancamovil/paginas/quejaspage.dart';
import 'package:bancamovil/servi_noti.dart';
//import 'package:bancamovil/paginas/reset_page.dart';
import 'package:bancamovil/paginas/solicitudes_novedades.dart';
import 'package:bancamovil/paginas/solicitudes_suministros.dart';
import 'package:bancamovil/paginas/home.dart';
import 'package:bancamovil/paginas/glosario.dart';
import 'package:bancamovil/paginas/busqueda.dart';
import 'package:bancamovil/paginas/provider.dart';
import 'package:bancamovil/paginas/registro.dart';
import 'package:bancamovil/paginas/perfil.dart';
import 'package:flutter/material.dart';
import 'package:bancamovil/paginas/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:bancamovil/paginas/chat.dart';
//import 'package:bancamovil/servi_noti.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotiService().initNotification();
  await Supabase.initialize(
    url: "https://cvfwvsvnpbwvhukasdtm.supabase.co",
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN2Znd2c3ZucGJ3dmh1a2FzZHRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk2MzkwNTgsImV4cCI6MjA1NTIxNTA1OH0.JQ1g27dHkG0NIb3YSLL3040TtFAETj9WSu_1ekcYx4c',
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,   // Vertical normal
  ]).then((_) {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Datamodel(),
      child: MyApp(),
    ),
  );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Gate(),
      routes:{
        '/home':(context)=> const Portada(),
        '/glosario':(context)=> const Glosario(),
        '/busqueda':(context)=>const Busqueda(),
        '/suministrosr':(context)=>const Historial(),
        '/novedadesr':(context)=>const NovedadesR(),
        '/login':(context)=> LoginPage(onTap: () {}),
        '/registro':(context)=> RegistroPage(onTap: () {}),
        //'/reset-password':(context)=> ResetPage(),
        //'/newpass': (context)=> SetNewPasswordPage(),
        '/data':(context) => Data(),
        '/quejas':(context)=> QuejasPage(),
        '/chat':(context)=> ChatPage(),
        '/perfil':(context)=> PerfilPage(),
      },
    );
  }
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(onTap: () {}),
        '/reset-password': (context) => ResetPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/set-new-password') {
          final uri = settings.arguments as Uri;
          return MaterialPageRoute(
            builder: (context) => SetNewPasswordPage(redirectUri: uri),
          );
        }
        return null;
      },
    );
  }
}
*/