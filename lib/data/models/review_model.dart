class ReviewsResponseModel {
  final bool? success;
  final String? message;
  final ReviewsMeta? meta;
  final List<ReviewData>? data;

  ReviewsResponseModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory ReviewsResponseModel.fromJson(Map<String, dynamic> json) {
    return ReviewsResponseModel(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null
          ? ReviewsMeta.fromJson(json['meta'])
          : null,
      data: json['data'] != null
          ? List<ReviewData>.from(
              json['data'].map((x) => ReviewData.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'meta': meta?.toJson(),
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class ReviewsMeta {
  final int? total;
  final int? totalPage;
  final int? page;
  final int? limit;

  ReviewsMeta({
    this.total,
    this.totalPage,
    this.page,
    this.limit,
  });

  factory ReviewsMeta.fromJson(Map<String, dynamic> json) {
    return ReviewsMeta(
      total: json['total'],
      totalPage: json['totalPage'],
      page: json['page'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'totalPage': totalPage,
      'page': page,
      'limit': limit,
    };
  }
}

class ReviewData {
  final String? id;
  final String? reviewNumber;
  final String? userId;
  final String? storeServiceId;
  final String? storeBundleId;
  final int? rating;
  final String? comment;
  final String? operatorReply;
  final String? createdAt;
  final String? updatedAt;
  final ReviewUser? user;

  ReviewData({
    this.id,
    this.reviewNumber,
    this.userId,
    this.storeServiceId,
    this.storeBundleId,
    this.rating,
    this.comment,
    this.operatorReply,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json['id'],
      reviewNumber: json['reviewNumber'],
      userId: json['userId'],
      storeServiceId: json['storeServiceId'],
      storeBundleId: json['storeBundleId'],
      rating: json['rating'],
      comment: json['comment'],
      operatorReply: json['operatorReply'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user:
          json['user'] != null ? ReviewUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewNumber': reviewNumber,
      'userId': userId,
      'storeServiceId': storeServiceId,
      'storeBundleId': storeBundleId,
      'rating': rating,
      'comment': comment,
      'operatorReply': operatorReply,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user?.toJson(),
    };
  }
}

class ReviewUser {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? avatar;

  ReviewUser({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.avatar,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'avatar': avatar,
    };
  }
}