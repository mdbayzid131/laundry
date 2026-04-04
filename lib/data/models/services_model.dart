class ServicesResponseModel {
  final bool? success;
  final String? message;
  final Meta? meta;
  final List<ServiceData>? data;

  ServicesResponseModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) {
    return ServicesResponseModel(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<ServiceData>.from(
              json['data'].map((x) => ServiceData.fromJson(x)),
            )
          : [],
    );
  }
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}

class ServiceData {
  final String? id;
  final String? operatorId;
  final String? categoryId;
  final String? name;
  final String? basePrice;
  final String? image;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  final List<ServiceAddon>? addons;
  final Category? category;
  final Operator? operator;

  ServiceData({
    this.id,
    this.operatorId,
    this.categoryId,
    this.name,
    this.basePrice,
    this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.addons,
    this.category,
    this.operator,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json['id'],
      operatorId: json['operatorId'],
      categoryId: json['categoryId'],
      name: json['name'],
      basePrice: json['basePrice'],
      image: json['image'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      addons: json['addons'] != null
          ? List<ServiceAddon>.from(
              json['addons'].map((x) => ServiceAddon.fromJson(x)),
            )
          : [],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      operator:
          json['operator'] != null ? Operator.fromJson(json['operator']) : null,
    );
  }
}

class ServiceAddon {
  final String? id;
  final String? serviceId;
  final String? addonId;
  final String? createdAt;
  final String? updatedAt;
  final Addon? addon;

  ServiceAddon({
    this.id,
    this.serviceId,
    this.addonId,
    this.createdAt,
    this.updatedAt,
    this.addon,
  });

  factory ServiceAddon.fromJson(Map<String, dynamic> json) {
    return ServiceAddon(
      id: json['id'],
      serviceId: json['serviceId'],
      addonId: json['addonId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      addon: json['addon'] != null ? Addon.fromJson(json['addon']) : null,
    );
  }
}

class Addon {
  final String? id;
  final String? operatorId;
  final String? name;
  final String? description;
  final bool? isActive;
  final String? price;
  final String? createdAt;
  final String? updatedAt;

  Addon({
    this.id,
    this.operatorId,
    this.name,
    this.description,
    this.isActive,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      id: json['id'],
      operatorId: json['operatorId'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'],
      price: json['price'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
class Category {
  final String? id;
  final String? name;
  final String? description;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
class Operator {
  final String? id;
  final String? userId;
  final String? storeName;
  final String? address;
  final double? latitude;
  final double? longitude;
  final dynamic platformFee;
  final String? stripeConnectId;
  final bool? onboardingComplete;
  final bool? chargesEnabled;
  final bool? payoutsEnabled;
  final String? createdAt;
  final String? updatedAt;
  final OperatorUser? user;

  Operator({
    this.id,
    this.userId,
    this.storeName,
    this.address,
    this.latitude,
    this.longitude,
    this.platformFee,
    this.stripeConnectId,
    this.onboardingComplete,
    this.chargesEnabled,
    this.payoutsEnabled,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'],
      userId: json['userId'],
      storeName: json['storeName'],
      address: json['address'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      platformFee: json['platformFee'],
      stripeConnectId: json['stripeConnectId'],
      onboardingComplete: json['onboardingComplete'],
      chargesEnabled: json['chargesEnabled'],
      payoutsEnabled: json['payoutsEnabled'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user:
          json['user'] != null ? OperatorUser.fromJson(json['user']) : null,
    );
  }
}
class OperatorUser {
  final String? name;
  final String? email;
  final String? phone;

  OperatorUser({
    this.name,
    this.email,
    this.phone,
  });

  factory OperatorUser.fromJson(Map<String, dynamic> json) {
    return OperatorUser(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}