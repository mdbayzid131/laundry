class FaqModel {
  final bool? success;
  final String? message;
  final Meta? meta;
  final List<FaqItem>? data;

  FaqModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<FaqItem>.from(
          json['data'].map((x) => FaqItem.fromJson(x)))
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
