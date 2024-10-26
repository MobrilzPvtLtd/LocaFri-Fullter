class PaymentData {
  bool? status;
  Data? data;

  PaymentData({this.status, this.data});

  PaymentData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
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
  String? totalPrice;
  String? remainingAmount;
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
  String? targetDate;
  String? status;

  Data(
      {this.name,
      this.email,
      this.addressFirst,
      this.addressLast,
      this.vehicleName,
      this.dayPrice,
      this.weekPrice,
      this.monthPrice,
      this.totalPrice,
      this.remainingAmount,
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
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    addressFirst = json['address_first'];
    addressLast = json['address_last'];
    vehicleName = json['vehicle_name'];
    dayPrice = json['day_price'];
    weekPrice = json['week_price'];
    monthPrice = json['month_price'];
    totalPrice = json['total_price'];
    remainingAmount = json['remaining_amount'];
    additionalDriver = json['additional_driver'];
    boosterSeat = json['booster_seat'];
    childSeat = json['child_seat'];
    exitPermit = json['exit_permit'];
    pickUpLocation = json['pickUpLocation'];
    dropOffLocation = json['dropOffLocation'];
    pickUpDate = json['pickUpDate'];
    pickUpTime = json['pickUpTime'];
    collectionTime = json['collectionTime'];
    collectionDate = json['collectionDate'];
    targetDate = json['targetDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address_first'] = this.addressFirst;
    data['address_last'] = this.addressLast;
    data['vehicle_name'] = this.vehicleName;
    data['day_price'] = this.dayPrice;
    data['week_price'] = this.weekPrice;
    data['month_price'] = this.monthPrice;
    data['total_price'] = this.totalPrice;
    data['remaining_amount'] = this.remainingAmount;
    data['additional_driver'] = this.additionalDriver;
    data['booster_seat'] = this.boosterSeat;
    data['child_seat'] = this.childSeat;
    data['exit_permit'] = this.exitPermit;
    data['pickUpLocation'] = this.pickUpLocation;
    data['dropOffLocation'] = this.dropOffLocation;
    data['pickUpDate'] = this.pickUpDate;
    data['pickUpTime'] = this.pickUpTime;
    data['collectionTime'] = this.collectionTime;
    data['collectionDate'] = this.collectionDate;
    data['targetDate'] = this.targetDate;
    data['status'] = this.status;
    return data;
  }
}
