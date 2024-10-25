class CreateContractData {
  bool? status;
  String? message;
  int? price;
  String? vehicleName;
  String? customerEmail;
  int? bookingId;
  String? paymentType;

  CreateContractData(
      {this.status,
      this.message,
      this.price,
      this.vehicleName,
      this.customerEmail,
      this.bookingId,
      this.paymentType});

  CreateContractData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    price = json['price'];
    vehicleName = json['vehicle_name'];
    customerEmail = json['customer_email'];
    bookingId = json['booking_id'];
    paymentType = json['payment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['price'] = this.price;
    data['vehicle_name'] = this.vehicleName;
    data['customer_email'] = this.customerEmail;
    data['booking_id'] = this.bookingId;
    data['payment_type'] = this.paymentType;
    return data;
  }
}
