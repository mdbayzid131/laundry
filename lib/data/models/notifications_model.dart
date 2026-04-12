class NotificationModel {
  final bool? success;
  final String? message;
  final Meta? meta;
  final List<NotificationItem>? data;

  NotificationModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<NotificationItem>.from(
          json['data'].map((x) => NotificationItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data": data?.map((e) => e.toJson()).toList(),
  };
}
class Meta {
  final int? total;
  final int? totalPage;
  final int? page;
  final int? limit;

  Meta({
    this.total,
    this.totalPage,
    this.page,
    this.limit,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      totalPage: json['totalPage'],
      page: json['page'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "totalPage": totalPage,
    "page": page,
    "limit": limit,
  };
}
class NotificationItem {
  final String? id;
  final String? userId;
  final String? operatorId;
  final String? title;
  final String? message;
  final String? channel;
  final String? type;
  final bool? isSent;
  final bool? isRead;
  final String? createdAt;

  NotificationItem({
    this.id,
    this.userId,
    this.operatorId,
    this.title,
    this.message,
    this.channel,
    this.type,
    this.isSent,
    this.isRead,
    this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      userId: json['userId'],
      operatorId: json['operatorId'],
      title: json['title'],
      message: json['message'],
      channel: json['channel'],
      type: json['type'],
      isSent: json['isSent'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "operatorId": operatorId,
    "title": title,
    "message": message,
    "channel": channel,
    "type": type,
    "isSent": isSent,
    "isRead": isRead,
    "createdAt": createdAt,
  };
}