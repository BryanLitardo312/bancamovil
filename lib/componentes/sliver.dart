import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  const MySliverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340.0,
      collapsedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.grey[900],
      title: const Text('Provisiones Blindado'),
      flexibleSpace: FlexibleSpaceBar(
        background: child,
        title:title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 0.0),
      ),
    );
  }
}