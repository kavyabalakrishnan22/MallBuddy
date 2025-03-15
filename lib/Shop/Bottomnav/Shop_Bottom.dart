import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../View/Screens/Home/shop_home_page.dart';
import '../View/Screens/shop_active_delivery.dart';
import '../View/Screens/shop_complete_delivery.dart';
import '../View/Screens/shop_select_parking.dart';
import '../View/Screens/shoporderhistory.dart';

class ShopBottomNavBarExample extends StatefulWidget {
  @override
  _ShopBottomNavBarExampleState createState() =>
      _ShopBottomNavBarExampleState();
}

class _ShopBottomNavBarExampleState extends State<ShopBottomNavBarExample> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ShopHomeScreen(),
    InvoiceFormPage(name: '', email: '', contact: '',),
    ActiveDeliveryPage(),
    CompleteDeliveryPage(),
    ShopOrderhistory(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSvgIcon(String assetName, bool isSelected) {
    return SvgPicture.asset(
      assetName,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.blue : Colors.black,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedLabelStyle:
            TextStyle(color: Colors.blue), // Selected label color
        unselectedLabelStyle:
            TextStyle(color: Colors.black), // Unselected label color
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
                'assets/ShopBottomnav/home.svg', _selectedIndex == 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
                'assets/ShopBottomnav/book.svg', _selectedIndex == 1),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
                'assets/ShopBottomnav/active.svg', _selectedIndex == 2),
            label: 'Active',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon('assets/ShopBottomnav/Completed.svg',
                _selectedIndex == 4),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon('assets/ShopBottomnav/status.svg',
                _selectedIndex == 5),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Shop Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Scan Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
class Status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
