import 'package:carapp/Controllers/search/search_controller.dart';
import 'package:carapp/ui/customerdetail/payment_screen.dart';
import 'package:carapp/ui/customerdetail/widget/other_request_widget.dart';
import 'package:carapp/ui/customerdetail/widget/additional_option_widget.dart';
import 'package:carapp/ui/customerdetail/widget/customer_datetime_field_widget.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/customerDetail/customer_detail_controller.dart';

class CustomerDetailScreen extends StatefulWidget {
  final String vehicleName;
  final String dPrice;
  final String wPrice;
  final String mPrice;

  const CustomerDetailScreen(
      {super.key,
      required this.vehicleName,
      required this.dPrice,
      required this.wPrice,
      required this.mPrice});
  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  List paymentType = <String>["PAY PARTIALLY 10%", "PAY FULL AMOUNT"];
  final SearchCarsController searchCarController =
      Get.put(SearchCarsController());

  final CustomerDetailController controller =
      Get.put(CustomerDetailController());

  final _formKey = GlobalKey<FormState>();

  DateTime? convertStringToDateTime(String dateString) {
    try {
      final format = DateFormat('dd/MM/yyyy');
      return format.parse(dateString);
    } catch (e) {
      print('Error: $e');
      return DateTime.now();
    }
  }

  TimeOfDay? convertStringToTimeOfDay(String timeString) {
    try {
      timeString = timeString.trim().toLowerCase();
      final isAm = timeString.endsWith('am');
      final isPm = timeString.endsWith('pm');

      if (!isAm && !isPm) {
        throw const FormatException(
            'Invalid time format. Use HH:mm or hh:mm AM/PM.');
      }

      timeString = timeString.replaceAll('am', '').replaceAll('pm', '').trim();

      final parts = timeString.split(':');
      int hour = int.parse(parts[0]);
      int minute = parts.length > 1 ? int.parse(parts[1]) : 0;

      if (isPm && hour < 12) {
        hour += 12;
      } else if (isAm && hour == 12) {
        hour = 0;
      }

      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
        throw RangeError(
            'Hour must be between 0-23 and minutes must be between 0-59.');
      }

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      print('Error: $e');
      return TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.width;
    controller.selectedPickUpLocation.value =
        searchCarController.pickUpLocationValue.value;
    controller.selectedDropOffLocation.value =
        searchCarController.dropOffLocationValue.value;
    controller.calculateDateDifference(
      searchCarController.pickUpDateAndTime.value,
      searchCarController.dropOfDateAndTime.value,
      widget.dPrice,
      widget.wPrice,
      widget.mPrice,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Formulaire détaillé",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontFamily: "UberMove",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: controller.updateFirstName,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Prénom",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom complet';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: controller.updateLastName,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Nom de famille",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom de famille';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  onChanged: controller.updatePhoneNumber,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Numéro de téléphone",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre numéro de téléphone';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    controller.updateEmail(value, context);
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  validator: controller.validateEmail,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "E-mail",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    suffix: Obx(() {
                      // Use Obx to observe the email verification status
                      return controller.verifyOtpStatus.value
                          ? const Icon(Icons.check_circle,
                              color: Colors.green) // Show green tick
                          : GestureDetector(
                              child: const Text("vérifier",
                                  style: TextStyle(color: Colors.blue)),
                              onTap: () {
                                controller.verifyEmail(
                                    controller.email.value, context);
                              },
                            );
                    }),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: controller.updateAddress,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Adresse",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre adresse';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: controller.updateCity,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Ville",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre ville';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: controller.updateZipCode,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Code postal",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre code postal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Lieu de prise en charge",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: 55,
                    width: width * 0.90,
                    child: DropdownButton<String>(
                      isDense: false,
                      icon: const Icon(
                        Icons.arrow_outward,
                        color: Colors.amber,
                      ),
                      value:
                          searchCarController.pickUpLocationValue.value.isEmpty
                              ? null
                              : searchCarController.pickUpLocationValue.value,
                      onChanged: (String? newValue) {
                        controller.selectedPickUpLocation.value = newValue!;
                        searchCarController.pickUpLocationValue.value =
                            newValue;
                      },
                      items: searchCarController.locations
                          .map<DropdownMenuItem<String>>((location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(
                            location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.045,
                              fontFamily: "UberMove",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: const Text(
                        "Sélectionnez votre lieu de prise en charge",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "UberMove"),
                      ),
                      isExpanded: true,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "UberMove"),
                    ),
                  ),
                ),
                const Text(
                  "Lieu de dépôt",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: 55,
                    width: width * 0.90,
                    child: DropdownButton<String>(
                      icon: const Icon(
                        Icons.arrow_outward,
                        color: Colors.amber,
                      ),
                      isDense: false,
                      value:
                          searchCarController.dropOffLocationValue.value.isEmpty
                              ? null
                              : searchCarController.dropOffLocationValue.value,
                      onChanged: (String? newValue) {
                        controller.selectedDropOffLocation.value = newValue!;
                        searchCarController.dropOffLocationValue.value =
                            newValue;
                      },
                      items: searchCarController.locations
                          .map<DropdownMenuItem<String>>((location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(
                            location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.045,
                              fontFamily: "UberMove",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: const Text(
                        "Sélectionnez votre lieu de dépôt",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "UberMove"),
                      ),
                      isExpanded: true,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "UberMove"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomerDateTimeField(
                  dPrice: widget.dPrice,
                  wPrice: widget.wPrice,
                  mPrice: widget.mPrice,
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mois",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          enabled: false,
                          onChanged: controller.updateMonth,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: "UberMove"),
                            hintText: controller.month.value,
                            focusColor: Colors.white,
                            disabledBorder: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Semaine",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          enabled: false,
                          onChanged: controller.updateWeek,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: "UberMove"),
                            hintText: controller.week.value,
                            focusColor: Colors.white,
                            disabledBorder: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Jours",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          enabled: false,
                          onChanged: controller.updateDays,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: "UberMove"),
                            hintText: controller.days.value,
                            focusColor: Colors.white,
                            disabledBorder: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Obx(
                  () => SwitchListTile(
                    title: const Text(
                      "Sélectionnez une option supplémentaire",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    value: controller.isAdditionalOptionEnabled.value,
                    onChanged: controller.toggleAdditionalOption,
                    activeColor: const Color(0xffff36a21),
                  ),
                ),
                Obx(() => controller.isAdditionalOptionEnabled.value
                    ? additionalOptionWidget(controller: controller)
                    : Container()),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return Container(
                    height: height * 0.18,
                    width: width * 0.70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Prix ​​total : -",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextField(
                              enabled: false,
                              controller: TextEditingController(
                                  text: controller.endPrice.value),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Montant',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SizedBox(
                      child: DropdownButton<String>(
                        icon: const Icon(
                          Icons.arrow_outward,
                          color: Colors.amber,
                        ),
                        value: controller.stripePaymentType.value.isEmpty
                            ? controller.paymentType.first
                            : controller.stripePaymentType.value,
                        onChanged: (String? newValue) {
                          controller.stripePaymentType.value = newValue!;
                        },
                        items: controller.paymentType
                            .map<DropdownMenuItem<String>>((paymenttype) {
                          return DropdownMenuItem<String>(
                            value: paymenttype,
                            child: Text(
                              paymenttype,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.045,
                                fontFamily: "UberMove",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          "Sélectionnez votre type de paiement",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.045,
                          fontFamily: "UberMove",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller
                            .submitForm(
                          context,
                          widget.vehicleName,
                          widget.dPrice,
                          widget.wPrice,
                          widget.mPrice,
                        )
                            .then(
                          (value) {
                            if (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                    fromCheckout: false,
                                    paymentUrl:
                                        controller.paymentRedirectUrl.value,
                                    vehicleName: controller
                                            .createContractData?.vehicleName
                                            .toString() ??
                                        "",
                                    email: controller
                                            .createContractData?.customerEmail
                                            .toString() ??
                                        "",
                                    price: controller.createContractData?.price
                                            .toString() ??
                                        "",
                                    bookingId: controller
                                            .createContractData?.bookingId
                                            .toString() ??
                                        "",
                                    paymentType:
                                        controller.stripePaymentType.value ==
                                                paymentType[0]
                                            ? "payment_partial"
                                            : "payment_full",
                                    token: SharedPrefs.getToken,
                                  ),
                                ),
                              );
                            } else {
                              Get.snackbar(
                                  "Échoué", "Quelque chose s'est mal passé");
                            }
                          },
                        );
                      }
                    },
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.90,
                      decoration: BoxDecoration(
                        color: const Color(0xffff36a21),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: controller.loading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Réservez maintenant",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget additionalOptionWidget(
      {required CustomerDetailController controller}) {
    return Column(
      children: [
        Obx(() {
          String additionalDriverText = controller.isAdditionalDriver.value
              ? "Conducteur supplémentaire \n(20 CHF par mois)"
              : "Conducteur supplémentaire";

          return Column(
            children: [
              AdditionalOptionsWidget(
                  switchvalue: controller.isAdditionalDriver.value,
                  text: additionalDriverText,
                  onChanged: (value) {
                    controller.toggleAdditionalDriver(value);
                  }),
              if (controller.isAdditionalDriver.value) ...{
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onChanged: controller.updateDriverFirstName,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "UberMove"),
                        hintText: "Prénom du conducteur",
                        focusColor: Colors.white,
                        disabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: controller.updateDriverLastName,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Nom de famille du conducteur",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              }
            ],
          );
        }),
        const SizedBox(
          height: 5,
        ),
        Obx(() {
          double childBoosterSeatPrice =
              controller.calculateChildBoosterSeatPrice();

          String childBoosterSeatText = controller.isChildBoosterSeat.value
              ? "Siège rehausseur pour enfant \n(${childBoosterSeatPrice.toStringAsFixed(0)} CHF par mois)"
              : "Siège rehausseur pour enfant";

          return AdditionalOptionsWidget(
            switchvalue: controller.isChildBoosterSeat.value,
            text: childBoosterSeatText,
            onChanged: (value) {
              controller.toggleChildBoosterSeats(value); // Call toggle method
            },
          );
        }),
        const SizedBox(
          height: 5,
        ),
        Obx(() {
          double calculateChildSeatPrice() {
            final int days = int.tryParse(controller.days.value) ?? 0;
            final int weeks = int.tryParse(controller.week.value) ?? 0;
            final int months = int.tryParse(controller.month.value) ?? 0;
            // return (days * 5) + (weeks * 30) + (months * 50);
            return 30.0;
          }

          String childSeatText = controller.isChildSeat.value
              ? "Siège enfant \n(${calculateChildSeatPrice().toStringAsFixed(0)} CHF par mois)"
              : "Siège enfant";

          return AdditionalOptionsWidget(
            switchvalue: controller.isChildSeat.value,
            text: childSeatText,
            onChanged: (value) {
              controller.toggleChildSeat(value); // Call toggle method
            },
          );
        }),
        const SizedBox(
          height: 5,
        ),
        Obx(() {
          String exitPermitText = controller.isExitPermit.value
              ? "Permis de sortie \n(149 CHF mois)"
              : "Permis de sortie";

          return AdditionalOptionsWidget(
            switchvalue: controller.isExitPermit.value,
            text: exitPermitText,
            onChanged: (value) {
              controller.toggleExitPermit(value); // Call toggle method
            },
          );
        }),
        const SizedBox(
          height: 5,
        ),
        const OtherRequestWidget(),
      ],
    );
  }
}
