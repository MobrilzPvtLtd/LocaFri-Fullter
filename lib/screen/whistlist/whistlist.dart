import 'package:flutter/material.dart';

class whistlist extends StatelessWidget {
  const whistlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            leading: const Text(""),
            scrolledUnderElevation: 0,
            elevation: 0,
              backgroundColor: Colors.white70,
              bottom: AppBar(
                leadingWidth: 0,
                leading: Text(""),

                // leading: IconButton(onPressed: (){
                //   Navigator.pop(context);
                // }, icon: const  Icon(Icons.arrow_back_ios,size: 30,color: Colors.black,)),
                scrolledUnderElevation: 0,
                title: const Text(
                  "All Cars",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: "UberMove"),
                ),
              ))),
              body: Container(),
    );
  }
}