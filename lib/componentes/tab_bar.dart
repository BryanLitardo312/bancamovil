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
          icon:Icon(Icons.local_shipping_rounded),
        ),
        Tab(
          icon:Icon(Icons.balance),
        ),
        Tab(
          icon:Icon(Icons.monetization_on_outlined),
        ),
      ],
      indicatorColor: Colors.grey[900],
    );
  }
}
