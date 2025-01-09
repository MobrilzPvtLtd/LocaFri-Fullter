import 'package:carapp/Controllers/auth/logout_controller.dart';
import 'package:carapp/ui/Profile/contactUs/contact_us_screen.dart';
import 'package:carapp/ui/Profile/profile_detail_screen.dart';
import 'package:carapp/ui/Profile/termsAndCondition/terms_condition.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:carapp/widget/buttonprofile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'keyBox/keybox.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final LogoutController controller = LogoutController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: const Text(""),
          backgroundColor: Colors.white10,
          bottom: AppBar(
            title: const Text(
              "Profil",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontFamily: "UberMove",
              ),
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
              Text(
                "${SharedPrefs.getUserFisrtName} ${SharedPrefs.getUserLastName}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Buttonprofile(
                icon: Icons.person,
                icon2: Icons.arrow_right,
                text: "Détail du profil",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileDetailScreen(),
                    ),
                  );
                },
              ),
              Buttonprofile(
                icon: Icons.article_rounded,
                icon2: Icons.arrow_right,
                text: "Boîte à clés",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KeyBox(),
                    ),
                  );
                },
              ),
              Buttonprofile(
                icon: Icons.article_rounded,
                icon2: Icons.arrow_right,
                text: "Termes et conditions",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermAndConditionScreen(),
                    ),
                  );
                },
              ),
              Buttonprofile(
                icon: Icons.article_rounded,
                icon2: Icons.arrow_right,
                text: "Contactez-nous",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactUsScreen(),
                    ),
                  );
                },
              ),
              Obx(
                () => Buttonprofile(
                  icon: Icons.logout,
                  icon2: controller.isLoading.value
                      ? Icons.disabled_by_default
                      : Icons.arrow_right,
                  text: "Déconnexion",
                  onPressed: () {
                    controller.logout(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
