class UserBookingDataModel {
  bool? status;
  List<Data>? data;

  UserBookingDataModel({this.status, this.data});

  UserBookingDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? contractId;
  int? bookingId;
  String? totalAmount;
  String? amountPaid;
  String? remainingAmount;
  String? paymentLink;
  Bookings? bookings;

  Data(
      {this.contractId,
      this.bookingId,
      this.totalAmount,
      this.amountPaid,
      this.remainingAmount,
      this.paymentLink,
      this.bookings});

  Data.fromJson(Map<String, dynamic> json) {
    contractId = json['contract_id'];
    bookingId = json['booking_id'];
    totalAmount = json['total_amount'];
    amountPaid = json['amount_paid'];
    remainingAmount = json['remaining_amount'];
    paymentLink = json['payment_link'];
    bookings = json['bookings'] != null
        ? new Bookings.fromJson(json['bookings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contract_id'] = this.contractId;
    data['booking_id'] = this.bookingId;
    data['total_amount'] = this.totalAmount;
    data['amount_paid'] = this.amountPaid;
    data['remaining_amount'] = this.remainingAmount;
    data['payment_link'] = this.paymentLink;
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.toJson();
    }
    return data;
  }
}

class Bookings {
  int? id;
  String? name;
  String? dprice;
  String? wprice;
  String? mprice;
  String? totalPrice;
  String? dayCount;
  String? weekCount;
  String? monthCount;
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
  String? paymentType;
  int? isViewbooking;
  int? isRejected;
  int? isContract;
  int? isConfirm;
  int? isComplete;
  int? seen;
  String? createdAt;
  String? updatedAt;
  Checkout? checkout;

  Bookings(
      {this.id,
      this.name,
      this.dprice,
      this.wprice,
      this.mprice,
      this.totalPrice,
      this.dayCount,
      this.weekCount,
      this.monthCount,
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
      this.paymentType,
      this.isViewbooking,
      this.isRejected,
      this.isContract,
      this.isConfirm,
      this.isComplete,
      this.seen,
      this.createdAt,
      this.updatedAt,
      this.checkout});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dprice = json['Dprice'];
    wprice = json['wprice'];
    mprice = json['mprice'];
    totalPrice = json['total_price'];
    dayCount = json['day_count'];
    weekCount = json['week_count'];
    monthCount = json['month_count'];
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
    paymentType = json['payment_type'];
    isViewbooking = json['is_viewbooking'];
    isRejected = json['is_rejected'];
    isContract = json['is_contract'];
    isConfirm = json['is_confirm'];
    isComplete = json['is_complete'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    checkout = json['checkout'] != null
        ? new Checkout.fromJson(json['checkout'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['Dprice'] = this.dprice;
    data['wprice'] = this.wprice;
    data['mprice'] = this.mprice;
    data['total_price'] = this.totalPrice;
    data['day_count'] = this.dayCount;
    data['week_count'] = this.weekCount;
    data['month_count'] = this.monthCount;
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
    data['payment_type'] = this.paymentType;
    data['is_viewbooking'] = this.isViewbooking;
    data['is_rejected'] = this.isRejected;
    data['is_contract'] = this.isContract;
    data['is_confirm'] = this.isConfirm;
    data['is_complete'] = this.isComplete;
    data['seen'] = this.seen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.checkout != null) {
      data['checkout'] = this.checkout!.toJson();
    }
    return data;
  }
}

class Checkout {
  int? id;
  int? bookingId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? addressFirst;
  String? addressLast;
  String? zipCode;
  String? createdAt;
  String? updatedAt;

  Checkout(
      {this.id,
      this.bookingId,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.addressFirst,
      this.addressLast,
      this.zipCode,
      this.createdAt,
      this.updatedAt});

  Checkout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    addressFirst = json['address_first'];
    addressLast = json['address_last'];
    zipCode = json['zipcode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address_first'] = this.addressFirst;
    data['address_last'] = this.addressLast;
    data['zipcode'] = this.zipCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
