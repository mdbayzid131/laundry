class PhoneSupportModel {
  final bool? success;
  final String? message;
  final List<SupportPhone>? data;

  PhoneSupportModel({
    this.success,
    this.message,
    this.data,
  });

  factory PhoneSupportModel.fromJson(Map<String, dynamic> json) {
    return PhoneSupportModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<SupportPhone>.from(
          json['data'].map((x) => SupportPhone.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.map((e) => e.toJson()).toList(),
  };
}
class SupportPhone {
  final String? id;
  final String? number;
  final String? availableTime;
  final String? avgWaitTime;
  final String? email;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  SupportPhone({
    this.id,
    this.number,
    this.availableTime,
    this.avgWaitTime,
    this.email,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory SupportPhone.fromJson(Map<String, dynamic> json) {
    return SupportPhone(
      id: json['id'],
      number: json['number'],
      availableTime: json['availableTime'],
      avgWaitTime: json['avgWaitTime'],
      email: json['email'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "availableTime": availableTime,
    "avgWaitTime": avgWaitTime,
    "email": email,
    "isActive": isActive,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}