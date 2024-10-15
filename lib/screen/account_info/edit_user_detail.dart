import 'package:carapp/screen/auth/Profile/profile.dart';
import 'package:carapp/screen/auth/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Edit_Account_info extends StatelessWidget {
  const Edit_Account_info({super.key});

  @override
  Widget build(BuildContext context) {
      final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
       appBar: PreferredSize(preferredSize:  const Size.fromHeight(90), child: AppBar(
         leading: Text(""),
        backgroundColor: Colors.white10,
      bottom: AppBar(
        title: const Text(
          "My Account Info",
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: "UberMove"),),
     
      ),),),
      body: SafeArea(
         minimum: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          hintText: "Full Name",
                          focusColor: Colors.white,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
        
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          hintText: "Last Name",
                          focusColor: Colors.white,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
        
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          hintText: "Email ID",
                          focusColor: Colors.white,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      cursorErrorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          hintText: "Password",
                          focusColor: Colors.white,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                      ),
                    ),
                  ),

                   GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile()));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: height * 0.08,
                    width: width * 0.90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffff36a21),

),
                    child: const Center(
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "UberMove",
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
        
        
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Sign_in()));
              //   },
              //   child: const  Row(
              //       children: [
              //         Icon(Icons.logout,
              //         size: 20,
              //         color: Color(0xffff36a21),

// ,),
//               //         Text("Logout",style: TextStyle(color: Color(0xffff36a21),

// ,fontSize: 20),),
              //       ],
              //     ),
              // )
          ],
        ),
      ),
    );
  }
}