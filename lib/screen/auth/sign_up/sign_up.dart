import 'package:carapp/screen/auth/sign_in/sign_in.dart';
import 'package:flutter/material.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontFamily: "PostsenOne"),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  // Validator

                  // decoration
                  decoration: InputDecoration(
                      hintText: "First Name",
                      focusColor: Colors.white,
                      disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),

              // Last Name
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
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

              // Email Field
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email Id",
                      focusColor: Colors.white,
                      disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),

              // Password Field

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  // password TextEditingController

                  // obscureText: obscureText.obscureText.value,
                  decoration: InputDecoration(
                      // suffixIcon: IconButton(onPressed: (){
                      //   obscureText.obscureText.value = !obscureText.obscureText.value;
                      // }, icon: Icon(obscureText.obscureText.value?Icons.visibility:Icons.visibility_off),),
                      hintText: "password",
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
                  decoration: InputDecoration(
                      hintText: "Confirm Password",
                      focusColor: Colors.white,
                      disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // Signup button

              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: height * 0.08,
                  width: width * 0.90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber),
                  child: const Center(
                    child: Text(
                      "SIGN UP ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          fontFamily: "DMSans"),
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
                  "Already have an account?",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: "DMSans"),
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const  Sign_in()));
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
                      "SIGN IN",
                      style: TextStyle(
                          color: Colors.white,
                           fontFamily: "DMSans",
                           fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child:
                      const Text("If You have Any Query Click Here Contact US!",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: "PlayfairDisplay",
                            color: Colors.white,
                          )),
                ),
              ),
            ]),
          ),
        )));
  }
}
