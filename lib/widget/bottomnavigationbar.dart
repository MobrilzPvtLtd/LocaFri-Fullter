import 'package:carapp/screen/Listof_cars/cardetail_list.dart';
import 'package:carapp/screen/Listof_cars/ListOfCar.dart';
import 'package:carapp/screen/auth/Profile/profile.dart';
import 'package:carapp/screen/home/home.dart';
import 'package:carapp/screen/key_box/keybox.dart';
import 'package:carapp/screen/whistlist/whistlist.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
   BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
int _currentindex = 0;

  List<Widget> pages= [
    const Home(),
    ListOfCar(),
    // whistlist(),
    const KeyBox()
    // Profile(),
  ];

 void _onItemTapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        currentIndex: _currentindex,
         onTap: _onItemTapped,
        iconSize: 30,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        items: const [
        BottomNavigationBarItem(
         backgroundColor: Colors.black, icon: Icon(Icons.home_filled,),label: "Home"),
        BottomNavigationBarItem(  backgroundColor: Colors.black,icon: Icon(Icons.directions_car),label: "Mobility",),
        // BottomNavigationBarItem( backgroundColor: Colors.black,icon: Icon(Icons.favorite),label: ""),
        BottomNavigationBarItem( backgroundColor: Colors.black,icon: Icon(Icons.wifi,),label: "KeyBox"),
      ]),
      body:IndexedStack(
        children: pages,
        index: _currentindex,
      )
    );
  }
}