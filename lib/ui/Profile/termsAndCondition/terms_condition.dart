import 'package:flutter/material.dart';

class TermAndConditionScreen extends StatelessWidget {
  const TermAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> termsAndCondition = {
      "Acceptance of Terms": [
        "By creating an account and using LocaFri, you accept and agree to comply with these Term and Condition. If you do not agree with these terms, please do not use our application."
      ],
      "User Responsibilities": [
        "Account Security: You are responsible for maintaining the confidentiality of your account information, including your password. You agree to notify us immediately of any unauthorized use of your account.",
        "Accurate Information: You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate and complete.",
        "Compliance with Laws: You agree to use LocaFri in compliance with all applicable local, state, national, and international laws and regulations."
      ],
      "Prohibited Activities": [
        "You agree not to engage in any of the following prohibited activities:",
        "Accessing or using LocaFri for any unlawful purpose or in violation of any applicable law.",
        "Interfering with or disrupting the integrity or performance of the application.",
        "Attempting to gain unauthorized access to the application or its related systems or networks.",
        "Transmitting any harmful or malicious code, files, or programs."
      ],
      "Intellectual Property": [
        "All content, trademarks, service marks, and logos on LocaFri are the property of their respective owners. You may not use, reproduce, or distribute any content from HRM without obtaining the necessary permissions."
      ],
      "Termination": [
        "We reserve the right to terminate or suspend your account at our sole discretion, without prior notice, if you violate these terms of service or engage in any prohibited activities."
      ],
      "Limitation of Liability": [
        "LocaFri shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of the application."
      ],
      "Changes to Terms": [
        "We reserve the right to modify these terms and Condition at any time.",
        "We will notify you of any changes by posting the new terms on our application.",
        "Your continued use of LocaFri after the changes take effect will constitute your acceptance of the revised terms."
      ],
      "Contact Us": [
        "If you have any questions about these terms and condition, please contact us at [your contact information]."
      ]
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Condition"),
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
                  "Welcome to LocaFri, your reliable Car Rent Company. Please read the following term and condition carefully before using our application. By accessing or using LocaFri, you agree to be bound by these terms and conditions."),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: termsAndCondition.entries.map((entry) {
                  String key = entry.key;
                  List<String> values = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTextWidget(key, fontWeight: FontWeight.bold),
                        const SizedBox(height: 8),
                        ...values.map(
                          (value) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: customTextWidget(value),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
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
