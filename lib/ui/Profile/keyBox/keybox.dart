import 'package:flutter/material.dart';

class KeyBox extends StatelessWidget {
  const KeyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,title: const  Text("KeyBox",style: TextStyle(fontSize: 20,fontFamily: "UberMove",fontWeight: FontWeight.w600),),),
      body: SafeArea(
        minimum: const  EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/keybox.png',height: 250,),
       const      SizedBox(height: 20,),
            
        RichText(text: const  TextSpan(children: [
          TextSpan(
            text: "La Smart Keybox est une boîte intelligente qui stocke la clé de voiture pour les retrouver facilement.",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: "UberMove",color: Colors.black)
          ),
          TextSpan(
            text: "Le locataire peut prendre et rendre le véhicule en l’absence d’une personne physique.",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: "UberMove",color: Color(0xffff36a21))
          ),
          TextSpan(
            text: "Locafri vous enverra un message (Whatsapp ou e-mail) avec le code pour ouvrir la box.",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: "UberMove",color: Colors.black)
          ),
          TextSpan(
            text: " Simple et facile d’utilisation,",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: "UberMove",color:Color(0xffff36a21) )
          ),
          TextSpan(
            text: "c’est un gain de temps pour les deux parties.",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: "UberMove",color: Colors.black)
          ),
        ]) )
          ],
        ),
      ),
    );
  }
}