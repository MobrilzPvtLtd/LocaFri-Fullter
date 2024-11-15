import 'package:carapp/ui/checkout/checkout_contract_screen.dart';
import 'package:carapp/ui/search/search_screen.dart';
import 'package:flutter/material.dart';
import '../ui/mobility/mobility_screen.dart';
import '../ui/checkin/checkin_contract_screen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentindex = 0;

  List<Widget> pages = [
    const SearchScreen(),
    MobilityScreen(),
    CheckinContractScreen(),
    const CheckoutContractScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        currentIndex: _currentindex,
        onTap: _onItemTapped,
        iconSize: 30,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.search),
              label: 'Search'),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.directions_car),
              label: 'Mobility'),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.check_box_outlined),
              label: 'Checkin'),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.logout),
              label: 'Checkout'),
        ],
      ),
      body: IndexedStack(
        children: pages,
        index: _currentindex,
      ),
    );
  }
}
