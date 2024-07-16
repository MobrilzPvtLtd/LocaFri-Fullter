import 'package:carapp/screen/account_info/edit_user_detail.dart';
import 'package:carapp/screen/auth/sign_in/sign_in.dart';
import 'package:carapp/screen/contact_us/contact_us.dart';
import 'package:carapp/widget/buttonprofile.dart';
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
        leading: Text(""),
        backgroundColor: Colors.white10,
      bottom: AppBar( title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: "UberMove"),),
     
      ),),),
      body:  SingleChildScrollView(
        child:  SafeArea(
          minimum: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("assets/images/person.jpg"),
              ),
              const Text("Mobrilz",style: TextStyle(color: Colors.black,fontSize: 30,fontFamily: "UberMove",fontWeight: FontWeight.bold),),
             const  SizedBox(height: 20,
              ),
              // Profile_Button( onPressed: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Edit_Account_info()));
              // },Icons: Icons.person, Icons2: Icons.arrow_right, text: "  Account info",),
              // Profile_Button(Icons: Icons.article_rounded, Icons2: Icons.arrow_right, text: "    Term&Condition"),
              // Profile_Button(Icons: Icons.article_rounded, Icons2: Icons.arrow_right, text: "    Privacy & Policy"),
              // Profile_Button(Icons: Icons.settings_applications_outlined, Icons2: Icons.arrow_right, text: "   Maintenance"),
              // Profile_Button(Icons: Icons.article_rounded, Icons2: Icons.arrow_right, text: "Key-Box"),
              // // Profile_Button(Icons: Icons.logout, Icons2: Icons.arrow_right, text: " Logout",onPressed:(){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sign_in()));},),
              // Profile_Button(Icons: Icons.chat_sharp, Icons2: Icons.arrow_right, text: " Contact us",onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>Contact_us()));},),
             
             const  buttonprofile(Icons: Icons.article_rounded, Icons2:  Icons.arrow_right, text: "Term&Condition"),
             const  buttonprofile(Icons: Icons.article_rounded, Icons2:  Icons.arrow_right, text: "Privacy & Policy"),
             const  buttonprofile(Icons: Icons.settings_applications_outlined, Icons2:  Icons.arrow_right, text: "Maintenance"),
             const  buttonprofile(Icons: Icons.article_rounded, Icons2:  Icons.arrow_right, text: "Key-Box"),
               buttonprofile(Icons: Icons.article_rounded, Icons2:  Icons.arrow_right, text: "Contact us",onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=> const Contact_us()));},),

            ],
          ),
        ),
      ),
    );
  }
}
