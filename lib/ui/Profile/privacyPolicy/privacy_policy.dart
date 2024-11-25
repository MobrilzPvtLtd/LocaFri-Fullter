import 'package:carapp/Controllers/profile/privacy_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final PrivacyPolicyController controller = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    controller.fetchPrivacyPolicyData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy & Policy"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: GetBuilder<PrivacyPolicyController>(builder: (context) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.error != null) {
            return Center(
              child: Text("Error : ${controller.error}"),
            );
          } else if (controller.privacyPolicyData != null) {
            final data = controller.privacyPolicyData;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                customTextWidget(
                  "Welcome to ${data!.companyName.toString()} Privacy Policy",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextWidget("For more info, visit us at : ", fontSize: 16),
                customTextWidget(
                  data.appUrl.toString(),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    customTextWidget("For any query : ", fontSize: 16),
                    customTextWidget(
                      data.appEmail.toString(),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextWidget(data.content!.introduction.toString(),
                    fontSize: 16),
                const SizedBox(
                  height: 10,
                ),
                customTextWidget(
                  data.content!.logFiles!.title.toString(),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                customTextWidget(data.content!.logFiles!.description.toString(),
                    fontSize: 16),
              ],
            );
          } else {
            return const Center(
              child: Text(
                "No Privacy Policy Available",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            );
          }
        }),
        // child: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const SizedBox(height: 8),
        //       customTextWidget(
        //           "At LocoFri, we are dedicated to safeguarding your privacy and ensuring the security of your personal information. Our privacy policy details the types of data we collect, how we utilize it, and the measures we implement to protect it. By using our LocaFri system, you agree to the collection and use of information in accordance with this policy. We collect information such as your name, email address, and usage data to provide and enhance our services, personalize your experience, and communicate effectively with you."),
        //       const SizedBox(height: 20),
        //       customTextWidget(
        //           "Transparency is a core value at LocaFri, and we aim to give you control over your data. Our app may employ third-party services that collect information to identify you. Rest assured, these third-party services are meticulously selected to meet our privacy standards. Additionally, we employ industry-standard security measures to protect your data from unauthorized access, alteration, disclosure, or destruction. Our privacy policy is designed to help you understand what data we collect, why we collect it, and how you can manage your information."),
        //       const SizedBox(height: 20),
        //       customTextWidget(
        //           "Your trust is paramount to us, and we are committed to protecting your privacy. We will not share your personal information with any third parties without your explicit consent, except as required by law or necessary to provide our services. If you have any questions or concerns about our privacy practices, please feel free to contact us. We may update our privacy policy periodically, and we encourage you to review this policy regularly to stay informed about how we are protecting your information.")
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

Widget customTextWidget(
  String text, {
  double? fontSize,
  double? wordSpacing,
  double? letterSpacing,
  double? textHeight,
  int? maxLines,
  TextAlign? textAlign,
  TextOverflow? overflow,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: TextStyle(
      height: textHeight,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
