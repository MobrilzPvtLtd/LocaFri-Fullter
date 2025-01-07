class PaymentStatusDataModel {
  bool? status;
  Data? data;

  PaymentStatusDataModel({this.status, this.data});

  PaymentStatusDataModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  static List<PaymentStatusDataModel> fromList(
      List<Map<String, dynamic>> list) {
    return list.map(PaymentStatusDataModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? name;
  String? email;
  String? addressFirst;
  String? addressLast;
  String? vehicleName;
  String? dayPrice;
  String? weekPrice;
  String? monthPrice;
  String? additionalDriver;
  String? boosterSeat;
  String? childSeat;
  String? exitPermit;
  String? pickUpLocation;
  String? dropOffLocation;
  String? pickUpDate;
  String? pickUpTime;
  String? collectionTime;
  String? collectionDate;
  dynamic targetDate;
  String? status;
  String? stripPaymentStatus;
  String? paymentType;
  String? paymentMethod;
  String? paymentStatus;
  String? totalPrice;
  String? amountPaid;
  int? remainingAmount;

  Data(
      {this.name,
      this.email,
      this.addressFirst,
      this.addressLast,
      this.vehicleName,
      this.dayPrice,
      this.weekPrice,
      this.monthPrice,
      this.additionalDriver,
      this.boosterSeat,
      this.childSeat,
      this.exitPermit,
      this.pickUpLocation,
      this.dropOffLocation,
      this.pickUpDate,
      this.pickUpTime,
      this.collectionTime,
      this.collectionDate,
      this.targetDate,
      this.status,
      this.stripPaymentStatus,
      this.paymentType,
      this.paymentMethod,
      this.paymentStatus,
      this.totalPrice,
      this.amountPaid,
      this.remainingAmount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["address_first"] is String) {
      addressFirst = json["address_first"];
    }
    if (json["address_last"] is String) {
      addressLast = json["address_last"];
    }
    if (json["vehicle_name"] is String) {
      vehicleName = json["vehicle_name"];
    }
    if (json["day_price"] is String) {
      dayPrice = json["day_price"];
    }
    if (json["week_price"] is String) {
      weekPrice = json["week_price"];
    }
    if (json["month_price"] is String) {
      monthPrice = json["month_price"];
    }
    if (json["additional_driver"] is String) {
      additionalDriver = json["additional_driver"];
    }
    if (json["booster_seat"] is String) {
      boosterSeat = json["booster_seat"];
    }
    if (json["child_seat"] is String) {
      childSeat = json["child_seat"];
    }
    if (json["exit_permit"] is String) {
      exitPermit = json["exit_permit"];
    }
    if (json["pickUpLocation"] is String) {
      pickUpLocation = json["pickUpLocation"];
    }
    if (json["dropOffLocation"] is String) {
      dropOffLocation = json["dropOffLocation"];
    }
    if (json["pickUpDate"] is String) {
      pickUpDate = json["pickUpDate"];
    }
    if (json["pickUpTime"] is String) {
      pickUpTime = json["pickUpTime"];
    }
    if (json["collectionTime"] is String) {
      collectionTime = json["collectionTime"];
    }
    if (json["collectionDate"] is String) {
      collectionDate = json["collectionDate"];
    }
    targetDate = json["targetDate"];
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["strip_payment_status"] is String) {
      stripPaymentStatus = json["strip_payment_status"];
    }
    if (json["payment_type"] is String) {
      paymentType = json["payment_type"];
    }
    if (json["payment_method"] is String) {
      paymentMethod = json["payment_method"];
    }
    if (json["payment_status"] is String) {
      paymentStatus = json["payment_status"];
    }
    if (json["total_price"] is String) {
      totalPrice = json["total_price"];
    }
    if (json["amount_paid"] is String) {
      amountPaid = json["amount_paid"];
    }
    if (json["remaining_amount"] is int) {
      remainingAmount = json["remaining_amount"];
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["email"] = email;
    _data["address_first"] = addressFirst;
    _data["address_last"] = addressLast;
    _data["vehicle_name"] = vehicleName;
    _data["day_price"] = dayPrice;
    _data["week_price"] = weekPrice;
    _data["month_price"] = monthPrice;
    _data["additional_driver"] = additionalDriver;
    _data["booster_seat"] = boosterSeat;
    _data["child_seat"] = childSeat;
    _data["exit_permit"] = exitPermit;
    _data["pickUpLocation"] = pickUpLocation;
    _data["dropOffLocation"] = dropOffLocation;
    _data["pickUpDate"] = pickUpDate;
    _data["pickUpTime"] = pickUpTime;
    _data["collectionTime"] = collectionTime;
    _data["collectionDate"] = collectionDate;
    _data["targetDate"] = targetDate;
    _data["status"] = status;
    _data["strip_payment_status"] = stripPaymentStatus;
    _data["payment_type"] = paymentType;
    _data["payment_method"] = paymentMethod;
    _data["payment_status"] = paymentStatus;
    _data["total_price"] = totalPrice;
    _data["amount_paid"] = amountPaid;
    _data["remaining_amount"] = remainingAmount;
    return _data;
  }
}
