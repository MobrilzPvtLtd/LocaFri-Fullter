import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy & Policy"), 
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              customTextWidget(
                  "At LocoFri, we are dedicated to safeguarding your privacy and ensuring the security of your personal information. Our privacy policy details the types of data we collect, how we utilize it, and the measures we implement to protect it. By using our LocaFri system, you agree to the collection and use of information in accordance with this policy. We collect information such as your name, email address, and usage data to provide and enhance our services, personalize your experience, and communicate effectively with you."),
              const SizedBox(height: 20),
              customTextWidget(
                  "Transparency is a core value at LocaFri, and we aim to give you control over your data. Our app may employ third-party services that collect information to identify you. Rest assured, these third-party services are meticulously selected to meet our privacy standards. Additionally, we employ industry-standard security measures to protect your data from unauthorized access, alteration, disclosure, or destruction. Our privacy policy is designed to help you understand what data we collect, why we collect it, and how you can manage your information."),
              const SizedBox(height: 20),
              customTextWidget(
                  "Your trust is paramount to us, and we are committed to protecting your privacy. We will not share your personal information with any third parties without your explicit consent, except as required by law or necessary to provide our services. If you have any questions or concerns about our privacy practices, please feel free to contact us. We may update our privacy policy periodically, and we encourage you to review this policy regularly to stay informed about how we are protecting your information.")
            ],
          ),
        ),
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
