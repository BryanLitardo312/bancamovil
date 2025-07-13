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
          text: 'Suministros',
          icon:Icon(Icons.local_shipping_rounded),
        ),
        Tab(
          text: 'Novedades',
          icon:Icon(Icons.balance),
        ),
        Tab(
          text: 'Retornos',
          icon:Icon(Icons.monetization_on_outlined),
        ),
      ],
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelColor: Colors.black,
      /*unselectedLabelColor: Colors.grey[400],*/
    );
  }
}
