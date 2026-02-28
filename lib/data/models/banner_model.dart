class BannerResponseModel {
  final bool success;
  final String message;
  final BannerDataModel data;

  BannerResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) {
    return BannerResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: BannerDataModel.fromJson(json['data']),
    );
  }
}
class BannerDataModel {
  final BannerMetaModel meta;
  final List<BannerModel> banners;

  BannerDataModel({
    required this.meta,
    required this.banners,
  });

  factory BannerDataModel.fromJson(Map<String, dynamic> json) {
    return BannerDataModel(
      meta: BannerMetaModel.fromJson(json['meta']),
      banners: (json['data'] as List)
          .map((e) => BannerModel.fromJson(e))
          .toList(),
    );
  }
}
class BannerMetaModel {
  final int total;
  final int limit;
  final int page;
  final int totalPage;

  BannerMetaModel({
    required this.total,
    required this.limit,
    required this.page,
    required this.totalPage,
  });

  factory BannerMetaModel.fromJson(Map<String, dynamic> json) {
    return BannerMetaModel(
      total: json['total'] ?? 0,
      limit: json['limit'] ?? 0,
      page: json['page'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}
class BannerModel {
  final String id;
  final String image;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  BannerModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
