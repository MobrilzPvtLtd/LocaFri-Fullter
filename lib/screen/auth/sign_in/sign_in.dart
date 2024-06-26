import 'package:carapp/screen/auth/Forget/forgetpassword.dart';
import 'package:carapp/screen/auth/sign_up/sign_up.dart';
import 'package:carapp/screen/home/home.dart';
import 'package:carapp/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Center(
                  child:Image.asset("assets/images/introduction_image.png"),),
                   const Text(
                    "Looking for a vehicle? \nYou're at the right place",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "UberMove"),
                  ),
                const SizedBox(
                  height: 20,
                ),

                // Password Field

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email ID",
                        hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily:"UberMove"
                      ),
                        focusColor: Colors.white,
                        disabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),

                /// Comfirm Password Field
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    // password TextEditingController

                    // obscureText: obscureText.obscureText.value,
                    decoration: InputDecoration(
                        // suffixIcon: IconButton(onPressed: (){
                        //   obscureText.obscureText.value = !obscureText.obscureText.value;
                        // }, icon: Icon(obscureText.obscureText.value?Icons.visibility:Icons.visibility_off),),
                        hintText: "Password",
                        focusColor: Colors.white,
                        hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily:"UberMove"
                      ),
                        disabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Forget_password()));
                  },
                  child: const Text(
                      textAlign: TextAlign.left,
                      "Forget Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "UberMove"
                      )),
                ),

                // Signup button

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => BottomNav()));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: height * 0.08,
                    width: width * 0.90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber),
                    child: const Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "UberMove",
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  endIndent: 50,
                  indent: 50,
                ),
                const Center(
                  child: Text(
                    "Don't Have an Account Yet",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: "UberMove",fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Sign_up()));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: height * 0.08,
                    width: width * 0.90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber),
                    child: const Center(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "UberMove",
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                        "If You have Any Query Click Here Contact US!",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontFamily: "UberMove",
                          fontWeight: FontWeight.bold
                        )),
                  ),
                ),
              ]),
        )));
  }
}
