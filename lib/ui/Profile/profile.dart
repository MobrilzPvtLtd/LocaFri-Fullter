import 'package:carapp/ui/Profile/contactUs/contact_us_screen.dart';
import 'package:carapp/widget/buttonprofile.dart';
import 'package:flutter/material.dart';
import 'keyBox/keybox.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          leading: const Text(""),
          backgroundColor: Colors.white10,
          bottom: AppBar(
            title: const Text(
              "Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontFamily: "UberMove"),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("assets/images/person.jpg"),
              ),
              const Text(
                "Mobrilz",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Buttonprofile(
                  icon: Icons.article_rounded,
                  icon2: Icons.arrow_right,
                  text: "Term&Condition"),
              const Buttonprofile(
                  icon: Icons.article_rounded,
                  icon2: Icons.arrow_right,
                  text: "Privacy & Policy"),
              const Buttonprofile(
                  icon: Icons.settings_applications_outlined,
                  icon2: Icons.arrow_right,
                  text: "Maintenance"),
              Buttonprofile(
                icon: Icons.article_rounded,
                icon2: Icons.arrow_right,
                text: "Key-Box",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const KeyBox()));
                },
              ),
              Buttonprofile(
                icon: Icons.article_rounded,
                icon2: Icons.arrow_right,
                text: "Contact us",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactUsScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
