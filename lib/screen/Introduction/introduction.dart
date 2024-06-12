import 'package:carapp/screen/auth/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
              Image.asset("assets/logo/splashscreen.png",
              height: 300,
              width: 300,
              ),
              Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Looking for a vehicle?\nYou're at the right\rplace.",
            style: TextStyle(fontFamily: "UberMove",
              color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),),
             const SizedBox(height: 20,),
              const Text(" Rent a Car Online Today & Enjoy The Best \r Deals Rates And Accessories",
            style: TextStyle(fontFamily: "UberMove",
              color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Sign_in()));
                },
                child: Center(
                  child: Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffff36a21),
                    ),
                    child: const  Center(child: Text("Let's Go!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                      fontFamily: "UberMove",color: Colors.black),)),
                  ),
                ),
              ),
              
          ],
        ),
          ],
        ),
      )
    );
  }
}