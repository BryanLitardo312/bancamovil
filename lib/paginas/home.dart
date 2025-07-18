import 'dart:async';
import 'package:bancamovil/componentes/cardwallet.dart';
import 'package:bancamovil/models/wallet.dart';
import 'package:bancamovil/servi_noti.dart';
import 'package:flutter/material.dart';
//import '../../componentes/navbar.dart';
import 'package:bancamovil/componentes/drawer.dart';
import 'package:bancamovil/componentes/button_detail.dart';
import 'package:provider/provider.dart';
import 'package:bancamovil/paginas/provider.dart';


class Portada extends StatefulWidget {
  const Portada ({super.key});
  @override
  State<Portada> createState() => _PortadaState();
  }



class _PortadaState extends State<Portada> {
  ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentIndex = 0;
  


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _startAutoScroll();
    });
  }
  
  

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }


  
  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double itemHeight = 55.0; // Altura de cada elemento en la lista
        double targetScroll = (_currentIndex * itemHeight).clamp(0.0, maxScroll);

        _scrollController.animateTo(
          targetScroll,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );

        _currentIndex++;
        if (targetScroll >= maxScroll) {
          _currentIndex = 0; // Reinicia el índice cuando llega al final
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<Datamodel>(
      builder:(context,value,child)=>Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left:12),
              child: Icon(Icons.menu,size: 30,),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 15),
                child:
                SizedBox(
                  height: 45,
                  width: 45,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(value.genero == 'M' ? 'lib/imagenes/hombre2.png' : 'lib/imagenes/mujer.png',),
                    ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right:30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text('Hola,', style: TextStyle(color: Colors.grey[600], fontSize: 17)),
                          Text(value.encargado.toString(), style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(context, '/chat');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.forum_sharp, size: 30, color: Colors.grey[900]),
                          ],
                        ),
                      ),
                      //value.correoInicio == 'brodriguezl@atimasa.com.ec' ? 
                      /*value.tipo == 'admin' ?
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          ElevatedButton(onPressed: () { NotiService().showNotification(title:'Breaking News',body:'Se actualizó el estado de cuenta.',);}, child: Icon(Icons.update,size:30,color:Colors.black)),
                        ],
                      ) : SizedBox.shrink(),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
          //const SizedBox(height: 5),
          card_wallet(
            wallet: Wallet(
              
              monto: double.parse(value.sumaAcumulada2.toStringAsFixed(1)) + double.parse(value.restaAcumulada2.toStringAsFixed(1)),
              //color: Colors.blue,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cash Flow',
                  style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 17)
                  ),
                  const SizedBox(width: 10),
                  MyButton2(
                    onTap: () => Navigator.pushNamed(context, '/busqueda'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Colors.grey[900]),
                        const SizedBox(width: 5),
                        Text(
                          'Notificaciones',
                          style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //height: 45,
                  width: screenWidth * 0.40,
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('lib/imagenes/incrementar.png',height: 40,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Créditos',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${value.sumaAcumulada2.toStringAsFixed(1)}',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  //height: 45,
                  width: screenWidth * 0.40,
                  //margin: const EdgeInsets.only(left: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('lib/imagenes/disminuir2.png',height: 40,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Débitos',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${value.restaAcumulada2.toStringAsFixed(1)}',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value.tipo=='usuario' ? 'Equipo Atimasa' : 'Red Atimasa',
                  style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 17)
                  ),
                  const SizedBox(width: 10),
                  MyButton2(
                    onTap: () => Navigator.pushNamed(context, '/data'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart, color: Colors.grey[900]),
                        const SizedBox(width: 5),
                        Text(
                          'Analítica',
                          style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
          const SizedBox(height: 15),//const SizedBox(height: 20),
          Flexible(
            child: SizedBox(
              //height: screenWidth*0.9,
              child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: value.acumuladosPorNombre.length,
                  itemBuilder: (context,index){
                    //final entry = value.acumuladosPorNombre;
                    return SizedBox(
                      //height: 55,
                      child: ListTile(
                        dense:true,
                        visualDensity: VisualDensity.compact,
                        minVerticalPadding: 0,  // Elimina padding vertical
                        //contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(value.tipo=='usuario' ? 'lib/imagenes/usuario.png' : 'lib/imagenes/gasolinera.png',),
                        ),
                        title: Text(value.acumuladosPorNombre.keys.elementAt(index).toString(),style:TextStyle(fontSize: value.tipo=='usuario'?15:16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis, ),
                        subtitle: Text(value.tipo=='usuario'?'Promotor':'Punto de Servicio',style:TextStyle(fontSize: 14)),
                        trailing: SizedBox(
                          width: screenWidth*0.22, // Ajusta el ancho según sea necesario
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                value.acumuladosPorNombre.values.elementAt(index).toStringAsFixed(2),
                                style: TextStyle(fontSize: 17, color: double.parse(value.acumuladosPorNombre.values.elementAt(index).toStringAsFixed(2)) >= 0 ? Colors.green : const Color.fromARGB(255, 194, 17, 4),fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        isThreeLine: false,
                      ),
                    );
                  }
                ),
              
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    ),
    );
  }
}
