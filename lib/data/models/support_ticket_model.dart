class SupportTicketResponse {
  final bool? success;
  final String? message;
  final Meta? meta;
  final List<SupportTicket>? data;

  SupportTicketResponse({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory SupportTicketResponse.fromJson(Map<String, dynamic> json) {
    return SupportTicketResponse(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<SupportTicket>.from(
              json['data'].map((x) => SupportTicket.fromJson(x)),
            )
          : [],
    );
  }
}

class Meta {
  final int? total;
  final int? totalPage;
  final int? page;
  final int? limit;

  Meta({this.total, this.totalPage, this.page, this.limit});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      totalPage: json['totalPage'],
      page: json['page'],
      limit: json['limit'],
    );
  }
}

class SupportTicket {
  final String? id;
  final String? ticketNumber;
  final String? userId;
  final String? orderId;
  final String? subject;
  final String? description;
  final String? status;
  final String? type;
  final String? createdAt;
  final String? updatedAt;
  final SupportUser? user;
  final List<SupportChatRoom>? chatRooms;

  SupportTicket({
    this.id,
    this.ticketNumber,
    this.userId,
    this.orderId,
    this.subject,
    this.description,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.chatRooms,
  });

  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
      id: json['id'],
      ticketNumber: json['ticketNumber'],
      userId: json['userId'],
      orderId: json['orderId'],
      subject: json['subject'],
      description: json['description'],
      status: json['status'],
      type: json['type'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: json['user'] != null ? SupportUser.fromJson(json['user']) : null,
      chatRooms: json['chatRooms'] != null
          ? List<SupportChatRoom>.from(
              json['chatRooms'].map((x) => SupportChatRoom.fromJson(x)),
            )
          : [],
    );
  }
}

class SupportUser {
  final String? id;
  final String? name;
  final String? email;
  final String? avatar;
  final String? phone;
  final String? role;

  SupportUser({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.phone,
    this.role,
  });

  factory SupportUser.fromJson(Map<String, dynamic> json) {
    return SupportUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}

class SupportChatRoom {
  final String? id;
  final String? name;
  final String? orderId;
  final String? ticketId;
  final String? createdAt;
  final String? updatedAt;

  SupportChatRoom({
    this.id,
    this.name,
    this.orderId,
    this.ticketId,
    this.createdAt,
    this.updatedAt,
  });

  factory SupportChatRoom.fromJson(Map<String, dynamic> json) {
    return SupportChatRoom(
      id: json['id'],
      name: json['name'],
      orderId: json['orderId'],
      ticketId: json['ticketId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
