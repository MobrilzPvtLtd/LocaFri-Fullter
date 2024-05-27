import 'package:carapp/screen/Listof_cars/cardetail_list.dart';
import 'package:carapp/screen/Listof_cars/show_page.dart';
import 'package:carapp/screen/auth/Profile/profile.dart';
import 'package:carapp/screen/home/home.dart';
import 'package:carapp/screen/whistlist/whistlist.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
   BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
int _currentindex = 0;

  List<Widget> pages= const [
    Home(),
    ListOfCar(),
    whistlist(),
    Profile(),
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
        currentIndex: _currentindex,
         onTap: _onItemTapped,
        iconSize: 30,
        unselectedItemColor: Colors.white,
        elevation: 0,
        items: const [
        BottomNavigationBarItem(
         backgroundColor: Colors.black, icon: Icon(Icons.home_filled,),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.directions_car),label: "",),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person,),label: ""),
      ]),
      body:IndexedStack(
        children: pages,
        index: _currentindex,
      )
    );
  }
}