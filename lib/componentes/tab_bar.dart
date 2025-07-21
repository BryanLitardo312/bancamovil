import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  const MyTabBar({
    super.key,
    required this.tabController,
    });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: [
        Tab(
          text: 'Provisión',
          icon:Icon(Icons.local_shipping_rounded,size:30,color:Colors.black),
        ),
        Tab(
          text: 'Novedades',
          icon:Icon(Icons.account_balance_rounded,size:30,color:Colors.black),
        ),
        Tab(
          text: 'Retornos',
          icon:Icon(Icons.monetization_on_outlined,size:30,color:Colors.black),
        ),
      ],
      /*indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[300], // Color de fondo del tab seleccionado
      ),*/
      indicatorPadding: EdgeInsets.symmetric(horizontal: 0.1),
      dividerColor: Colors.grey[200],
      indicatorColor: const Color.fromARGB(255, 13, 70, 116),
      indicatorWeight:5.0,
      labelStyle: const TextStyle(
        fontSize: 17,
        //fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey[900],
    );
  }
}
