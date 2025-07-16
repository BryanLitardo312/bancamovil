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
          icon:Icon(Icons.local_shipping_rounded),
        ),
        Tab(
          text: 'Novedades',
          icon:Icon(Icons.account_balance),
        ),
        Tab(
          text: 'Retornos',
          icon:Icon(Icons.monetization_on_outlined),
        ),
      ],
      isScrollable: false,
      dividerColor: Colors.grey[900],
      indicatorColor: Colors.blue,
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey[500],
    );
  }
}
