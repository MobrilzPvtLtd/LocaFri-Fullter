class UserBookingDataModel {
  bool? status;
  List<Data>? data;

  UserBookingDataModel({this.status, this.data});

  UserBookingDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? bookingId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  Null? addressFirst;
  Null? addressLast;
  String? createdAt;
  String? updatedAt;
  Booking? booking;

  Data(
      {this.id,
        this.bookingId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.addressFirst,
        this.addressLast,
        this.createdAt,
        this.updatedAt,
        this.booking});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    addressFirst = json['address_first'];
    addressLast = json['address_last'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    booking =
    json['booking'] != null ?  Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['address_first'] = addressFirst;
    data['address_last'] = addressLast;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    return data;
  }
}

class Booking {
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
  Null? targetDate;
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
  Transaction? transaction;

  Booking(
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
        this.transaction});

  Booking.fromJson(Map<String, dynamic> json) {
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
    transaction = json['transaction'] != null
        ?  Transaction.fromJson(json['transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['Dprice'] = dprice;
    data['wprice'] = wprice;
    data['mprice'] = mprice;
    data['total_price'] = totalPrice;
    data['day_count'] = dayCount;
    data['week_count'] = weekCount;
    data['month_count'] = monthCount;
    data['additional_driver'] = additionalDriver;
    data['booster_seat'] = boosterSeat;
    data['child_seat'] = childSeat;
    data['exit_permit'] = exitPermit;
    data['pickUpLocation'] = pickUpLocation;
    data['dropOffLocation'] = dropOffLocation;
    data['pickUpDate'] = pickUpDate;
    data['pickUpTime'] = pickUpTime;
    data['collectionTime'] = collectionTime;
    data['collectionDate'] = collectionDate;
    data['targetDate'] = targetDate;
    data['status'] = status;
    data['payment_type'] = paymentType;
    data['is_viewbooking'] = isViewbooking;
    data['is_rejected'] = isRejected;
    data['is_contract'] = isContract;
    data['is_confirm'] = isConfirm;
    data['is_complete'] = isComplete;
    data['seen'] = seen;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class Transaction {
  int? id;
  int? orderId;
  String? transactionId;
  String? amount;
  String? currency;
  String? paymentMethod;
  String? dateTime;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;

  Transaction(
      {this.id,
        this.orderId,
        this.transactionId,
        this.amount,
        this.currency,
        this.paymentMethod,
        this.dateTime,
        this.paymentStatus,
        this.createdAt,
        this.updatedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    currency = json['currency'];
    paymentMethod = json['payment_method'];
    dateTime = json['date_time'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['order_id'] = orderId;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['currency'] = currency;
    data['payment_method'] = paymentMethod;
    data['date_time'] = dateTime;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
