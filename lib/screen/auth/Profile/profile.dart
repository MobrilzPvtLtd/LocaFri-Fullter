import 'package:carapp/widget/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(preferredSize:  const Size.fromHeight(90), child: AppBar(
        backgroundColor: Colors.white10,
      bottom: AppBar( title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: "DMSans"),),
     
      ),),),
      body: const Column(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage("assets/images/person.jpg"),
          ),
          Text("Mobrilz",style: TextStyle(color: Colors.black,fontSize: 30,fontFamily: "DMSans"),),
          SizedBox(height: 20,
          ),
          Profile_Button(Icons: Icons.person, Icons2: Icons.arrow_right, text: "Account info"),
          Profile_Button(Icons: Icons.article_rounded, Icons2: Icons.arrow_right, text: "Term&Condition"),
          Profile_Button(Icons: Icons.article_rounded, Icons2: Icons.arrow_right, text: "Privacy & Policy"),
        ],
      ),
    );
  }
}
