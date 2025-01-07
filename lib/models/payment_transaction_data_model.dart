class PaymentTransactionDataModel {
  bool? status;
  Data? data;

  PaymentTransactionDataModel({this.status, this.data});

  PaymentTransactionDataModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  static List<PaymentTransactionDataModel> fromList(
      List<Map<String, dynamic>> list) {
    return list.map(PaymentTransactionDataModel.fromJson).toList();
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
  String? bookingStatus;
  String? paymentPaid;
  String? paymentType;
  String? paymentMethod;
  String? totalPrice;
  String? amountPaid;
  String? remainingAmount;

  Data(
      {this.bookingStatus,
      this.paymentPaid,
      this.paymentType,
      this.paymentMethod,
      this.totalPrice,
      this.amountPaid,
      this.remainingAmount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["booking_status"] is String) {
      bookingStatus = json["booking_status"];
    }
    if (json["payment_paid"] is String) {
      paymentPaid = json["payment_paid"];
    }
    if (json["payment_type"] is String) {
      paymentType = json["payment_type"];
    }
    if (json["payment_method"] is String) {
      paymentMethod = json["payment_method"];
    }
    if (json["total_price"] is String) {
      totalPrice = json["total_price"];
    }
    if (json["amount_paid"] is String) {
      amountPaid = json["amount_paid"];
    }
    if (json["remaining_amount"] is String) {
      remainingAmount = json["remaining_amount"];
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["booking_status"] = bookingStatus;
    _data["payment_paid"] = paymentPaid;
    _data["payment_type"] = paymentType;
    _data["payment_method"] = paymentMethod;
    _data["total_price"] = totalPrice;
    _data["amount_paid"] = amountPaid;
    _data["remaining_amount"] = remainingAmount;
    return _data;
  }
}
