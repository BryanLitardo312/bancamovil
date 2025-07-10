import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ButtonNav extends StatelessWidget {
  
  final Function(int) onTabChange;
  
  const ButtonNav ({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return GNav(
      padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 20),
      color: Colors.grey[600],
      activeColor: Colors.grey.shade900,
      iconSize: 35,
      tabActiveBorder: Border.all(color: Colors.white),
      tabBackgroundColor: Colors.grey.shade100,
      mainAxisAlignment: MainAxisAlignment.center,
      tabBorderRadius: 16,
      onTabChange: (value) => onTabChange(value),
      tabs:const [
        GButton(
          icon: Icons.home,
          text: 'Inicio',
        ),
        GButton(
          icon: Icons.book_outlined,
          text: 'Registros',
        ),
        GButton(
          icon: Icons.search,
          text: 'Búsqueda',
        ),
      ],
    );
  }
}