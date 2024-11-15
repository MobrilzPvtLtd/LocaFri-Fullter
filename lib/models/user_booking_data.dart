class UserBookingData {
  bool? status;
  String? message;
  List<BookingData>? data;

  UserBookingData({this.status, this.message, this.data});

  UserBookingData.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => BookingData.fromJson(e)).toList();
    }
  }

  static List<UserBookingData> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserBookingData.fromJson).toList();
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

class BookingData {
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

  BookingData(
      {this.bookingId,
      this.vehicleName,
      this.totalPrice,
      this.status,
      this.pickUpLocation,
      this.dropOffLocation,
      this.pickUpDate,
      this.collectionDate,
      this.createdAt,
      this.statusDescription});

  BookingData.fromJson(Map<String, dynamic> json) {
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
  }

  static List<BookingData> fromList(List<Map<String, dynamic>> list) {
    return list.map(BookingData.fromJson).toList();
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
    return _data;
  }
}
