import 'package:carapp/screen/auth/Profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contact_us extends StatefulWidget {
  const Contact_us({super.key});

  @override
  State<Contact_us> createState() => _Contact_usState();
}

class _Contact_usState extends State<Contact_us> {
   bool? checkbox = false;
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
          "Contact us",
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
                      maxLines: 8,
                      maxLength: 500,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          hintText: "Message",
                          focusColor: Colors.white,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                
                Row(
                  children: [
                    Checkbox(value: checkbox, onChanged: (newBool) {
                      setState(() {
                        checkbox = newBool;
                      });
                    },
                    tristate: false,
                    activeColor: Color(0xffff36a21),
                    
                    ),
                  const
                    Text("I have read and accept the privacy policy.",style: TextStyle(fontSize: 15,fontFamily: "UberMove",color: Colors.black, fontWeight: FontWeight.w600),)
                  ],
                ),
                   GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile()));
                    Get.showSnackbar(GetSnackBar(
                      title: "Thank you for contacting us.",
                      message: "We have sent you an email with the information you have requested.",
                      duration: Duration(seconds: 3),
                    ));
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
                        "Send",
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