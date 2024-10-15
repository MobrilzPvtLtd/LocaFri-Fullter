import 'package:carapp/screen/Listof_cars/cardetail_list.dart';
import 'package:carapp/screen/Listof_cars/ListOfCar.dart';
import 'package:carapp/screen/auth/Profile/profile.dart';
import 'package:carapp/screen/contract/checkout_contract.dart';
import 'package:carapp/screen/home/home.dart';
import 'package:carapp/screen/key_box/keybox.dart';
import 'package:carapp/screen/mainpage/home-2.dart';
import 'package:carapp/screen/mainpage/mainpage.dart';
import 'package:carapp/screen/whistlist/whistlist.dart';
import 'package:flutter/material.dart';

import '../screen/Listof_cars/All_CarsList.dart';
import '../screen/contract/checkin_contract.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({super.key});
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}
class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentindex = 0;

  List<Widget> pages = [
    MainSecond(),
    AllCarList(),
    checkin_contract(),
    checkout_contract(),
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
              // room_service
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.wifi),
                  label: 'KeyBox'),
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.check_box_outlined),
                  label: 'Checkout'),

              // selectedItemColor: Colors.orange,
            ]),
        body: IndexedStack(
          children: pages,
          index: _currentindex,
        ));
  }
}
