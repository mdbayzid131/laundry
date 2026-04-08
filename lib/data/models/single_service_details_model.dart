class StoreServiceDetailsResponseModel {
  final bool? success;
  final String? message;
  final StoreServiceDetailsData? data;

  StoreServiceDetailsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory StoreServiceDetailsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return StoreServiceDetailsResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? StoreServiceDetailsData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}
class StoreServiceDetailsData {
  final String? id;
  final String? storeId;
  final String? serviceId;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final StoreServiceService? service;
  final StoreServiceStore? store;
  final List<Review>? reviews;
  final ServiceCount? count;

  StoreServiceDetailsData({
    this.id,
    this.storeId,
    this.serviceId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.store,
    this.reviews,
    this.count,
  });

  factory StoreServiceDetailsData.fromJson(Map<String, dynamic> json) {
    return StoreServiceDetailsData(
      id: json['id'],
      storeId: json['storeId'],
      serviceId: json['serviceId'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      service: json['service'] != null
          ? StoreServiceService.fromJson(json['service'])
          : null,
      store: json['store'] != null
          ? StoreServiceStore.fromJson(json['store'])
          : null,
      reviews: json['reviews'] != null
          ? List<Review>.from(json['reviews'].map((x) => Review.fromJson(x)))
          : [],
      count: json['_count'] != null
          ? ServiceCount.fromJson(json['_count'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'serviceId': serviceId,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'service': service?.toJson(),
      'store': store?.toJson(),
      'reviews': reviews?.map((x) => x.toJson()).toList(),
      '_count': count?.toJson(),
    };
  }
}

class StoreServiceService {
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
  final ServiceCategory? category;
  final List<ServiceAddonLink>? serviceAddons;
  final List<StoreServiceLink>? storeServices;
  final ServiceOperator? operator;

  StoreServiceService({
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
    this.category,
    this.serviceAddons,
    this.storeServices,
    this.operator,
  });

  factory StoreServiceService.fromJson(Map<String, dynamic> json) {
    return StoreServiceService(
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
      category: json['category'] != null
          ? ServiceCategory.fromJson(json['category'])
          : null,
      serviceAddons: json['serviceAddons'] != null
          ? List<ServiceAddonLink>.from(
              json['serviceAddons'].map(
                (x) => ServiceAddonLink.fromJson(x),
              ),
            )
          : [],
      storeServices: json['storeServices'] != null
          ? List<StoreServiceLink>.from(
              json['storeServices'].map(
                (x) => StoreServiceLink.fromJson(x),
              ),
            )
          : [],
      operator: json['operator'] != null
          ? ServiceOperator.fromJson(json['operator'])
          : null,
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
      'category': category?.toJson(),
      'serviceAddons': serviceAddons?.map((x) => x.toJson()).toList(),
      'storeServices': storeServices?.map((x) => x.toJson()).toList(),
      'operator': operator?.toJson(),
    };
  }
}

class Review {
  final String? id;
  final int? rating;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;
  final String? userId;

  Review({
    this.id,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userId': userId,
    };
  }
}


class ServiceCategory {
  final String? id;
  final String? name;
  final String? description;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  ServiceCategory({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class ServiceAddonLink {
  final String? id;
  final String? serviceId;
  final String? addonId;
  final String? createdAt;
  final String? updatedAt;
  final ServiceAddon? addon;

  ServiceAddonLink({
    this.id,
    this.serviceId,
    this.addonId,
    this.createdAt,
    this.updatedAt,
    this.addon,
  });

  factory ServiceAddonLink.fromJson(Map<String, dynamic> json) {
    return ServiceAddonLink(
      id: json['id'],
      serviceId: json['serviceId'],
      addonId: json['addonId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      addon: json['addon'] != null ? ServiceAddon.fromJson(json['addon']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'addonId': addonId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'addon': addon?.toJson(),
    };
  }
}

class ServiceAddon {
  final String? id;
  final String? operatorId;
  final String? name;
  final String? price;
  final String? description;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  ServiceAddon({
    this.id,
    this.operatorId,
    this.name,
    this.price,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceAddon.fromJson(Map<String, dynamic> json) {
    return ServiceAddon(
      id: json['id'],
      operatorId: json['operatorId'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
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
      'price': price,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class StoreServiceLink {
  final String? id;
  final String? storeId;
  final String? serviceId;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  StoreServiceLink({
    this.id,
    this.storeId,
    this.serviceId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreServiceLink.fromJson(Map<String, dynamic> json) {
    return StoreServiceLink(
      id: json['id'],
      storeId: json['storeId'],
      serviceId: json['serviceId'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'serviceId': serviceId,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class ServiceOperator {
  final String? id;
  final String? operatorId;
  final String? userId;
  final String? approvalStatus;
  final String? status;
  final String? stripeConnectedAccountId;
  final String? onboardingUrl;
  final bool? onboardingComplete;
  final String? createdAt;
  final String? updatedAt;

  ServiceOperator({
    this.id,
    this.operatorId,
    this.userId,
    this.approvalStatus,
    this.status,
    this.stripeConnectedAccountId,
    this.onboardingUrl,
    this.onboardingComplete,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceOperator.fromJson(Map<String, dynamic> json) {
    return ServiceOperator(
      id: json['id'],
      operatorId: json['operatorId'],
      userId: json['userId'],
      approvalStatus: json['approvalStatus'],
      status: json['status'],
      stripeConnectedAccountId: json['stripeConnectedAccountId'],
      onboardingUrl: json['onboardingUrl'],
      onboardingComplete: json['onboardingComplete'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operatorId': operatorId,
      'userId': userId,
      'approvalStatus': approvalStatus,
      'status': status,
      'stripeConnectedAccountId': stripeConnectedAccountId,
      'onboardingUrl': onboardingUrl,
      'onboardingComplete': onboardingComplete,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class ServiceCount {
  final int? reviews;

  ServiceCount({
    this.reviews,
  });

  factory ServiceCount.fromJson(Map<String, dynamic> json) {
    return ServiceCount(
      reviews: json['reviews'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviews': reviews,
    };
  }
}

class StoreServiceStore {
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

  StoreServiceStore({
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

  factory StoreServiceStore.fromJson(Map<String, dynamic> json) {
    return StoreServiceStore(
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
      lat: json['lat'] != null
          ? double.tryParse(json['lat'].toString())
          : null,
      lng: json['lng'] != null
          ? double.tryParse(json['lng'].toString())
          : null,
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

