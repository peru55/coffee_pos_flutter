import 'package:coffee_pos/app/modules/cart/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'products/product_view.dart';
// import other pages as needed (e.g., CartView, ProfileView)

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ProductView(),
    CartView(),   // Replace with CartView()
    Center(child: Text('Profile Page')), // Replace with ProfileView()
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.brown.shade200,
        backgroundColor: Colors.brown.shade50,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
