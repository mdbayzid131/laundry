class NotificationPreferenceModel {
  final bool? success;
  final String? message;
  final NotificationPreferenceData? data;

  NotificationPreferenceModel({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationPreferenceModel.fromJson(Map<String, dynamic> json) {
    return NotificationPreferenceModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? NotificationPreferenceData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}


class NotificationPreferenceData {
  final String? id;
  final String? userId;
  final bool? push;
  final bool? sms;
  final bool? email;
  final String? createdAt;
  final String? updatedAt;

  NotificationPreferenceData({
    this.id,
    this.userId,
    this.push,
    this.sms,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationPreferenceData.fromJson(Map<String, dynamic> json) {
    return NotificationPreferenceData(
      id: json['id'],
      userId: json['userId'],
      push: json['push'],
      sms: json['sms'],
      email: json['email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "push": push,
        "sms": sms,
        "email": email,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}