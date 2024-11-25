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
        child: GetBuilder<PrivacyPolicyController>(
          builder: (context) {
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
                  customTextWidget("For more info, visit us at : ",
                      fontSize: 16),
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
                  customTextWidget(
                      data.content!.logFiles!.description.toString(),
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
          },
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
