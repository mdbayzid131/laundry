class OrderIssueResponse {
  final bool? success;
  final String? message;
  final MetaData? meta;
  final List<OrderIssue>? data;

  OrderIssueResponse({this.success, this.message, this.meta, this.data});

  factory OrderIssueResponse.fromJson(Map<String, dynamic> json) {
    return OrderIssueResponse(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? (json['data'] as List).map((i) => OrderIssue.fromJson(i)).toList()
          : null,
    );
  }
}

class SingleOrderIssueResponse {
  final bool? success;
  final String? message;
  final OrderIssue? data;

  SingleOrderIssueResponse({this.success, this.message, this.data});

  factory SingleOrderIssueResponse.fromJson(Map<String, dynamic> json) {
    return SingleOrderIssueResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? OrderIssue.fromJson(json['data']) : null,
    );
  }
}

class MetaData {
  final int? total;
  final int? totalPage;
  final int? page;
  final int? limit;

  MetaData({this.total, this.totalPage, this.page, this.limit});

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      total: json['total'],
      totalPage: json['totalPage'],
      page: json['page'],
      limit: json['limit'],
    );
  }
}

class OrderIssue {
  final String? id;
  final String? orderId;
  final String? userId;
  final String? operatorId;
  final String? issueTitle;
  final String? description;
  final List<String>? images;
  final String? status;
  final String? refundAmount;
  final String? operatorNote;
  final String? adminNote;
  final bool? isEscalated;
  final String? escalationNote;
  final String? createdAt;
  final String? updatedAt;
  final IssueOrder? order;
  final IssueUser? user;

  OrderIssue({
    this.id,
    this.orderId,
    this.userId,
    this.operatorId,
    this.issueTitle,
    this.description,
    this.images,
    this.status,
    this.refundAmount,
    this.operatorNote,
    this.adminNote,
    this.isEscalated,
    this.escalationNote,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.user,
  });

  factory OrderIssue.fromJson(Map<String, dynamic> json) {
    return OrderIssue(
      id: json['id'],
      orderId: json['orderId'],
      userId: json['userId'],
      operatorId: json['operatorId'],
      issueTitle: json['issueTitle'],
      description: json['description'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      status: json['status'],
      refundAmount: json['refundAmount']?.toString(),
      operatorNote: json['operatorNote'],
      adminNote: json['adminNote'],
      isEscalated: json['isEscalated'],
      escalationNote: json['escalationNote'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      order: json['order'] != null ? IssueOrder.fromJson(json['order']) : null,
      user: json['user'] != null ? IssueUser.fromJson(json['user']) : null,
    );
  }
}

class IssueOrder {
  final String? id;
  final String? orderNumber;
  final String? status;
  final String? totalAmount;

  IssueOrder({this.id, this.orderNumber, this.status, this.totalAmount});

  factory IssueOrder.fromJson(Map<String, dynamic> json) {
    return IssueOrder(
      id: json['id'],
      orderNumber: json['orderNumber'],
      status: json['status'],
      totalAmount: json['totalAmount'],
    );
  }
}

class IssueUser {
  final String? name;
  final String? email;

  IssueUser({this.name, this.email});

  factory IssueUser.fromJson(Map<String, dynamic> json) {
    return IssueUser(
      name: json['name'],
      email: json['email'],
    );
  }
}
