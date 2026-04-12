class AdsResponseModel {
  final bool? success;
  final String? message;
  final AdsMeta? meta;
  final List<AdData>? data;

  AdsResponseModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory AdsResponseModel.fromJson(Map<String, dynamic> json) {
    return AdsResponseModel(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? AdsMeta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<AdData>.from(
              json['data'].map((x) => AdData.fromJson(x)),
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

class AdsMeta {
  final int? total;
  final int? page;
  final int? limit;

  AdsMeta({
    this.total,
    this.page,
    this.limit,
  });

  factory AdsMeta.fromJson(Map<String, dynamic> json) {
    return AdsMeta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'page': page,
      'limit': limit,
    };
  }
}

class AdData {
  final String? id;
  final String? operatorId;
  final String? subscriptionId;
  final String? status;
  final String? createdAt;
  final String? storeBundleId;
  final String? storeServiceId;
  final String? serviceName;
  final String? serviceImage;
  final String? bundleName;
  final String? bundleImage;

  final AdOperator? operator;
  final AdStore? store;
  final AdService? service;
  final AdBundle? bundle;

  final double? avgRating;
  final int? totalReviewCount;
  final double? distanceMeters;
  final double? distanceMile;

  AdData({
    this.id,
    this.operatorId,
    this.subscriptionId,
    this.status,
    this.createdAt,
    this.storeBundleId,
    this.storeServiceId,
    this.serviceName,
    this.serviceImage,
    this.bundleName,
    this.bundleImage,
    this.operator,
    this.store,
    this.service,
    this.bundle,
    this.avgRating,
    this.totalReviewCount,
    this.distanceMeters,
    this.distanceMile,
  });

  factory AdData.fromJson(Map<String, dynamic> json) {
    return AdData(
      id: json['id'],
      operatorId: json['operatorId'],
      subscriptionId: json['subscriptionId'],
      status: json['status'],
      createdAt: json['createdAt'],
      storeBundleId: json['storeBundleId'],
      storeServiceId: json['storeServiceId'],
      serviceName: json['serviceName'],
      serviceImage: json['serviceImage'],
      bundleName: json['bundleName'],
      bundleImage: json['bundleImage'],
      operator: json['operator'] != null ? AdOperator.fromJson(json['operator']) : null,
      store: json['store'] != null ? AdStore.fromJson(json['store']) : null,
      service: json['service'] != null ? AdService.fromJson(json['service']) : null,
      bundle: json['bundle'] != null ? AdBundle.fromJson(json['bundle']) : null,
      avgRating: json['avgRating'] != null ? double.tryParse(json['avgRating'].toString()) : null,
      totalReviewCount: json['totalReviewCount'],
      distanceMeters: json['distance_meters'] != null ? double.tryParse(json['distance_meters'].toString()) : null,
      distanceMile: json['distanceMile'] != null ? double.tryParse(json['distanceMile'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operatorId': operatorId,
      'subscriptionId': subscriptionId,
      'status': status,
      'createdAt': createdAt,
      'storeBundleId': storeBundleId,
      'storeServiceId': storeServiceId,
      'serviceName': serviceName,
      'serviceImage': serviceImage,
      'bundleName': bundleName,
      'bundleImage': bundleImage,
      'operator': operator?.toJson(),
      'store': store?.toJson(),
      'service': service?.toJson(),
      'bundle': bundle?.toJson(),
      'avgRating': avgRating,
      'totalReviewCount': totalReviewCount,
      'distance_meters': distanceMeters,
      'distanceMile': distanceMile,
    };
  }
}

class AdOperator {
  final String? id;
  final AdUser? user;

  AdOperator({
    this.id,
    this.user,
  });

  factory AdOperator.fromJson(Map<String, dynamic> json) {
    return AdOperator(
      id: json['id'],
      user: json['user'] != null ? AdUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
    };
  }
}

class AdUser {
  final String? name;
  final String? avatar;

  AdUser({
    this.name,
    this.avatar,
  });

  factory AdUser.fromJson(Map<String, dynamic> json) {
    return AdUser(
      name: json['name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
    };
  }
}

class AdStore {
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

  AdStore({
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

  factory AdStore.fromJson(Map<String, dynamic> json) {
    return AdStore(
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
      lat: json['lat'] != null ? double.tryParse(json['lat'].toString()) : null,
      lng: json['lng'] != null ? double.tryParse(json['lng'].toString()) : null,
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operatorId': operatorId,
      'name': name,
      'logo': logo,
      'banner': banner,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'postalCode': postalCode,
      'lat': lat,
      'lng': lng,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class AdService {
  final String? id;
  final String? operatorId;
  final String? categoryId;
  final String? name;
  final double? basePrice;
  final String? description;
  final String? image;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  AdService({
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

  factory AdService.fromJson(Map<String, dynamic> json) {
    return AdService(
      id: json['id'],
      operatorId: json['operatorId'],
      categoryId: json['categoryId'],
      name: json['name'],
      basePrice: json['basePrice'] != null ? double.tryParse(json['basePrice'].toString()) : null,
      description: json['description'],
      image: json['image'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operatorId': operatorId,
      'categoryId': categoryId,
      'name': name,
      'basePrice': basePrice,
      'description': description,
      'image': image,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class AdBundle {
  final String? id;
  final String? name;
  final String? image;

  AdBundle({
    this.id,
    this.name,
    this.image,
  });

  factory AdBundle.fromJson(Map<String, dynamic> json) {
    return AdBundle(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}