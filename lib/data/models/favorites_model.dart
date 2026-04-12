class FavoritesModel {
  final bool? success;
  final String? message;
  final List<FavoriteItem>? data;

  FavoritesModel({
    this.success,
    this.message,
    this.data,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<FavoriteItem>.from(
          json['data'].map((x) => FavoriteItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.map((e) => e.toJson()).toList(),
  };
}
class FavoriteItem {
  final String? id;
  final String? userId;
  final String? serviceId;
  final String? storeServiceId;
  final String? storeBundleId;
  final String? createdAt;
  final String? updatedAt;

  final StoreService? storeService;

  FavoriteItem({
    this.id,
    this.userId,
    this.serviceId,
    this.storeServiceId,
    this.storeBundleId,
    this.createdAt,
    this.updatedAt,
    this.storeService,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      userId: json['userId'],
      serviceId: json['serviceId'],
      storeServiceId: json['storeServiceId'],
      storeBundleId: json['storeBundleId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      storeService: json['storeService'] != null
          ? StoreService.fromJson(json['storeService'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {};
}
class StoreService {
  final String? id;
  final String? storeId;
  final String? serviceId;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  final Service? service;
  final Store? store;

  StoreService({
    this.id,
    this.storeId,
    this.serviceId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.store,
  });

  factory StoreService.fromJson(Map<String, dynamic> json) {
    return StoreService(
      id: json['id'],
      storeId: json['storeId'],
      serviceId: json['serviceId'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      service:
      json['service'] != null ? Service.fromJson(json['service']) : null,
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
    );
  }
}
class Service {
  final String? id;
  final String? operatorId;
  final String? categoryId;
  final String? name;
  final String? basePrice;
  final String? description;
  final String? image;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  Service({
    this.id,
    this.operatorId,
    this.categoryId,
    this.name,
    this.basePrice,
    this.description,
    this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      operatorId: json['operatorId'],
      categoryId: json['categoryId'],
      name: json['name'],
      basePrice: json['basePrice'],
      description: json['description'],
      image: json['image'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
class Store {
  final String? id;
  final String? operatorId;
  final String? name;
  final String? logo;
  final String? banner;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? postalCode;
  final double? lat;
  final double? lng;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  Store({
    this.id,
    this.operatorId,
    this.name,
    this.logo,
    this.banner,
    this.address,
    this.country,
    this.state,
    this.city,
    this.postalCode,
    this.lat,
    this.lng,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      operatorId: json['operatorId'],
      name: json['name'],
      logo: json['logo'],
      banner: json['banner'],
      address: json['address'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      postalCode: json['postalCode'],
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}