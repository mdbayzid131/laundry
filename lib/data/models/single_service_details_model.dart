class ServiceDetailsResponseModel {
  final bool? success;
  final String? message;
  final ServiceDetailsData? data;

  ServiceDetailsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ServiceDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ServiceDetailsData.fromJson(json['data'])
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

class ServiceDetailsData {
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

  ServiceDetailsData({
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

  factory ServiceDetailsData.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsData(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operatorId': operatorId,
      'categoryId': categoryId,
      'name': name,
      'basePrice': basePrice,
      'image': image,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'addons': addons?.map((x) => x.toJson()).toList(),
      'category': category?.toJson(),
      'operator': operator?.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operatorId': operatorId,
      'name': name,
      'description': description,
      'isActive': isActive,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
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
      user: json['user'] != null ? OperatorUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'storeName': storeName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'platformFee': platformFee,
      'stripeConnectId': stripeConnectId,
      'onboardingComplete': onboardingComplete,
      'chargesEnabled': chargesEnabled,
      'payoutsEnabled': payoutsEnabled,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user?.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}