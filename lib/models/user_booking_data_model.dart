class UserBookingDataModel {
  bool? status;
  String? message;
  List<Data>? data;

  UserBookingDataModel({this.status, this.message, this.data});

  UserBookingDataModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  static List<UserBookingDataModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserBookingDataModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? bookingId;
  String? vehicleName;
  String? totalPrice;
  String? status;
  String? pickUpLocation;
  String? dropOffLocation;
  String? pickUpDate;
  String? collectionDate;
  String? createdAt;
  String? statusDescription;
  Transaction? transaction;

  Data(
      {this.bookingId,
      this.vehicleName,
      this.totalPrice,
      this.status,
      this.pickUpLocation,
      this.dropOffLocation,
      this.pickUpDate,
      this.collectionDate,
      this.createdAt,
      this.statusDescription,
      this.transaction});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["booking_id"] is int) {
      bookingId = json["booking_id"];
    }
    if (json["vehicle_name"] is String) {
      vehicleName = json["vehicle_name"];
    }
    if (json["total_price"] is String) {
      totalPrice = json["total_price"];
    }
    if (json["status"] is String) {
      status = json["status"];
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
    if (json["collectionDate"] is String) {
      collectionDate = json["collectionDate"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["status_description"] is String) {
      statusDescription = json["status_description"];
    }
    if (json["transaction"] is Map) {
      transaction = json["transaction"] == null
          ? null
          : Transaction.fromJson(json["transaction"]);
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["booking_id"] = bookingId;
    _data["vehicle_name"] = vehicleName;
    _data["total_price"] = totalPrice;
    _data["status"] = status;
    _data["pickUpLocation"] = pickUpLocation;
    _data["dropOffLocation"] = dropOffLocation;
    _data["pickUpDate"] = pickUpDate;
    _data["collectionDate"] = collectionDate;
    _data["created_at"] = createdAt;
    _data["status_description"] = statusDescription;
    if (transaction != null) {
      _data["transaction"] = transaction?.toJson();
    }
    return _data;
  }
}

class Transaction {
  String? transactionId;
  String? amount;
  String? currency;
  String? paymentMethod;
  String? paymentStatus;
  String? dateTime;

  Transaction(
      {this.transactionId,
      this.amount,
      this.currency,
      this.paymentMethod,
      this.paymentStatus,
      this.dateTime});

  Transaction.fromJson(Map<String, dynamic> json) {
    if (json["transaction_id"] is String) {
      transactionId = json["transaction_id"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
    if (json["currency"] is String) {
      currency = json["currency"];
    }
    if (json["payment_method"] is String) {
      paymentMethod = json["payment_method"];
    }
    if (json["payment_status"] is String) {
      paymentStatus = json["payment_status"];
    }
    if (json["date_time"] is String) {
      dateTime = json["date_time"];
    }
  }

  static List<Transaction> fromList(List<Map<String, dynamic>> list) {
    return list.map(Transaction.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["transaction_id"] = transactionId;
    _data["amount"] = amount;
    _data["currency"] = currency;
    _data["payment_method"] = paymentMethod;
    _data["payment_status"] = paymentStatus;
    _data["date_time"] = dateTime;
    return _data;
  }
}
