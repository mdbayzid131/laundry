class MyOrdersResponseModel {
  final bool? success;
  final String? message;
  final MyOrdersMeta? meta;
  final List<MyOrderData>? data;

  MyOrdersResponseModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory MyOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    return MyOrdersResponseModel(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? MyOrdersMeta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<MyOrderData>.from(
              json['data'].map((x) => MyOrderData.fromJson(x)),
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

class MyOrdersMeta {
  final int? total;
  final int? totalPage;
  final int? page;
  final int? limit;

  MyOrdersMeta({
    this.total,
    this.totalPage,
    this.page,
    this.limit,
  });

  factory MyOrdersMeta.fromJson(Map<String, dynamic> json) {
    return MyOrdersMeta(
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

class MyOrderData {
  final String? id;
  final String? orderNumber;
  final String? userId;
  final String? status;
  final String? paymentStatus;
  final String? subtotal;
  final String? pickupAndDeliveryFee;
  final String? platformFee;
  final String? fixedTransactionFee;
  final String? totalAmount;
  final String? actualPickupAndDeliveryFee;
  final bool? isSubscription;
  final String? scheduledDate;
  final String? stripePaymentIntentId;
  final String? stripeTransferGroup;
  final String? paymentUrl;
  final String? createdAt;
  final String? updatedAt;

  final OrderUser? user;
  final PickupAddress? pickupAddress;
  final DeliveryAddress? deliveryAddress;
  final List<OrderItemModel>? orderItems;
  final List<OperatorOrderModel>? operatorOrders;
  final OrderPaymentModel? payment;

  MyOrderData({
    this.id,
    this.orderNumber,
    this.userId,
    this.status,
    this.paymentStatus,
    this.subtotal,
    this.pickupAndDeliveryFee,
    this.platformFee,
    this.fixedTransactionFee,
    this.totalAmount,
    this.actualPickupAndDeliveryFee,
    this.isSubscription,
    this.scheduledDate,
    this.stripePaymentIntentId,
    this.stripeTransferGroup,
    this.paymentUrl,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.pickupAddress,
    this.deliveryAddress,
    this.orderItems,
    this.operatorOrders,
    this.payment,
  });

  factory MyOrderData.fromJson(Map<String, dynamic> json) {
    return MyOrderData(
      id: json['id'],
      orderNumber: json['orderNumber'],
      userId: json['userId'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      subtotal: json['subtotal'],
      pickupAndDeliveryFee: json['pickupAndDeliveryFee'],
      platformFee: json['platformFee'],
      fixedTransactionFee: json['fixedTransactionFee'],
      totalAmount: json['totalAmount'],
      actualPickupAndDeliveryFee: json['actualPickupAndDeliveryFee'],
      isSubscription: json['isSubscription'],
      scheduledDate: json['scheduledDate'],
      stripePaymentIntentId: json['stripePaymentIntentId'],
      stripeTransferGroup: json['stripeTransferGroup'],
      paymentUrl: json['paymentUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: json['user'] != null ? OrderUser.fromJson(json['user']) : null,
      pickupAddress: json['pickupAddress'] != null
          ? PickupAddress.fromJson(json['pickupAddress'])
          : null,
      deliveryAddress: json['deliveryAddress'] != null
          ? DeliveryAddress.fromJson(json['deliveryAddress'])
          : null,
      orderItems: json['orderItems'] != null
          ? List<OrderItemModel>.from(
              json['orderItems'].map((x) => OrderItemModel.fromJson(x)),
            )
          : [],
      operatorOrders: json['operatorOrders'] != null
          ? List<OperatorOrderModel>.from(
              json['operatorOrders'].map((x) => OperatorOrderModel.fromJson(x)),
            )
          : [],
      payment: json['payment'] != null
          ? OrderPaymentModel.fromJson(json['payment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'userId': userId,
      'status': status,
      'paymentStatus': paymentStatus,
      'subtotal': subtotal,
      'pickupAndDeliveryFee': pickupAndDeliveryFee,
      'platformFee': platformFee,
      'fixedTransactionFee': fixedTransactionFee,
      'totalAmount': totalAmount,
      'actualPickupAndDeliveryFee': actualPickupAndDeliveryFee,
      'isSubscription': isSubscription,
      'scheduledDate': scheduledDate,
      'stripePaymentIntentId': stripePaymentIntentId,
      'stripeTransferGroup': stripeTransferGroup,
      'paymentUrl': paymentUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user?.toJson(),
      'pickupAddress': pickupAddress?.toJson(),
      'deliveryAddress': deliveryAddress?.toJson(),
      'orderItems': orderItems?.map((x) => x.toJson()).toList(),
      'operatorOrders': operatorOrders?.map((x) => x.toJson()).toList(),
      'payment': payment?.toJson(),
    };
  }
}

class OrderUser {
  final String? name;
  final String? email;

  OrderUser({
    this.name,
    this.email,
  });

  factory OrderUser.fromJson(Map<String, dynamic> json) {
    return OrderUser(
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}

class PickupAddress {
  final String? id;
  final String? orderId;
  final String? pickupTime;
  final String? pickupDate;
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  PickupAddress({
    this.id,
    this.orderId,
    this.pickupTime,
    this.pickupDate,
    this.streetAddress,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  factory PickupAddress.fromJson(Map<String, dynamic> json) {
    return PickupAddress(
      id: json['id'],
      orderId: json['orderId'],
      pickupTime: json['pickupTime'],
      pickupDate: json['pickupDate'],
      streetAddress: json['streetAddress'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'pickupTime': pickupTime,
      'pickupDate': pickupDate,
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }
}

class DeliveryAddress {
  final String? id;
  final String? orderId;
  final String? deliveryTime;
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  DeliveryAddress({
    this.id,
    this.orderId,
    this.deliveryTime,
    this.streetAddress,
    this.city,
    this.state,
    this.country,
    this.postalCode,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['id'],
      orderId: json['orderId'],
      deliveryTime: json['deliveryTime'],
      streetAddress: json['streetAddress'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'deliveryTime': deliveryTime,
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }
}

class OrderItemModel {
  final String? id;
  final String? orderId;
  final String? operatorOrderId;
  final String? serviceName;
  final int? quantity;
  final String? price;
  final String? storeServiceId;
  final String? storeBundleId;
  final String? createdAt;

  final OrderStoreServiceModel? storeService;
  final OrderStoreBundleModel? storeBundle;
  final List<OrderAddonModel>? orderAddons;

  OrderItemModel({
    this.id,
    this.orderId,
    this.operatorOrderId,
    this.serviceName,
    this.quantity,
    this.price,
    this.storeServiceId,
    this.storeBundleId,
    this.createdAt,
    this.storeService,
    this.storeBundle,
    this.orderAddons,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      orderId: json['orderId'],
      operatorOrderId: json['operatorOrderId'],
      serviceName: json['serviceName'],
      quantity: json['quantity'],
      price: json['price'],
      storeServiceId: json['storeServiceId'],
      storeBundleId: json['storeBundleId'],
      createdAt: json['createdAt'],
      storeService: json['storeService'] != null
          ? OrderStoreServiceModel.fromJson(json['storeService'])
          : null,
      storeBundle: json['storeBundle'] != null
          ? OrderStoreBundleModel.fromJson(json['storeBundle'])
          : null,
      orderAddons: json['orderAddons'] != null
          ? List<OrderAddonModel>.from(
              json['orderAddons'].map((x) => OrderAddonModel.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'operatorOrderId': operatorOrderId,
      'serviceName': serviceName,
      'quantity': quantity,
      'price': price,
      'storeServiceId': storeServiceId,
      'storeBundleId': storeBundleId,
      'createdAt': createdAt,
      'storeService': storeService?.toJson(),
      'storeBundle': storeBundle?.toJson(),
      'orderAddons': orderAddons?.map((x) => x.toJson()).toList(),
    };
  }
}

class OrderStoreServiceModel {
  final String? id;
  final String? storeId;
  final String? serviceId;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final OrderServiceModel? service;
  final OrderCountModel? count;

  OrderStoreServiceModel({
    this.id,
    this.storeId,
    this.serviceId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.count,
  });

  factory OrderStoreServiceModel.fromJson(Map<String, dynamic> json) {
    return OrderStoreServiceModel(
      id: json['id'],
      storeId: json['storeId'],
      serviceId: json['serviceId'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      service: json['service'] != null
          ? OrderServiceModel.fromJson(json['service'])
          : null,
      count: json['_count'] != null
          ? OrderCountModel.fromJson(json['_count'])
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
      '_count': count?.toJson(),
    };
  }
}

class OrderServiceModel {
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

  OrderServiceModel({
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

  factory OrderServiceModel.fromJson(Map<String, dynamic> json) {
    return OrderServiceModel(
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

class OrderCountModel {
  final int? reviews;

  OrderCountModel({
    this.reviews,
  });

  factory OrderCountModel.fromJson(Map<String, dynamic> json) {
    return OrderCountModel(
      reviews: json['reviews'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviews': reviews,
    };
  }
}

class OrderStoreBundleModel {
  final String? id;

  OrderStoreBundleModel({
    this.id,
  });

  factory OrderStoreBundleModel.fromJson(Map<String, dynamic> json) {
    return OrderStoreBundleModel(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

class OrderAddonModel {
  final String? id;

  OrderAddonModel({
    this.id,
  });

  factory OrderAddonModel.fromJson(Map<String, dynamic> json) {
    return OrderAddonModel(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

class OperatorOrderModel {
  final String? id;
  final String? orderId;
  final String? operatorId;
  final String? storeId;
  final String? subtotal;
  final String? transferAmount;
  final String? transferStatus;
  final String? stripeTransferId;
  final String? createdAt;
  final OrderStoreModel? store;

  OperatorOrderModel({
    this.id,
    this.orderId,
    this.operatorId,
    this.storeId,
    this.subtotal,
    this.transferAmount,
    this.transferStatus,
    this.stripeTransferId,
    this.createdAt,
    this.store,
  });

  factory OperatorOrderModel.fromJson(Map<String, dynamic> json) {
    return OperatorOrderModel(
      id: json['id'],
      orderId: json['orderId'],
      operatorId: json['operatorId'],
      storeId: json['storeId'],
      subtotal: json['subtotal'],
      transferAmount: json['transferAmount'],
      transferStatus: json['transferStatus'],
      stripeTransferId: json['stripeTransferId'],
      createdAt: json['createdAt'],
      store:
          json['store'] != null ? OrderStoreModel.fromJson(json['store']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'operatorId': operatorId,
      'storeId': storeId,
      'subtotal': subtotal,
      'transferAmount': transferAmount,
      'transferStatus': transferStatus,
      'stripeTransferId': stripeTransferId,
      'createdAt': createdAt,
      'store': store?.toJson(),
    };
  }
}

class OrderStoreModel {
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

  OrderStoreModel({
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

  factory OrderStoreModel.fromJson(Map<String, dynamic> json) {
    return OrderStoreModel(
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

class OrderPaymentModel {
  final String? id;
  final String? orderId;
  final String? stripePaymentIntentId;
  final String? stripeTransferGroup;
  final String? amount;
  final String? currency;
  final String? status;
  final String? paymentUrl;
  final String? paidAt;
  final String? transactionId;
  final String? createdAt;
  final String? updatedAt;

  OrderPaymentModel({
    this.id,
    this.orderId,
    this.stripePaymentIntentId,
    this.stripeTransferGroup,
    this.amount,
    this.currency,
    this.status,
    this.paymentUrl,
    this.paidAt,
    this.transactionId,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderPaymentModel.fromJson(Map<String, dynamic> json) {
    return OrderPaymentModel(
      id: json['id'],
      orderId: json['orderId'],
      stripePaymentIntentId: json['stripePaymentIntentId'],
      stripeTransferGroup: json['stripeTransferGroup'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      paymentUrl: json['paymentUrl'],
      paidAt: json['paidAt'],
      transactionId: json['transactionId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'stripePaymentIntentId': stripePaymentIntentId,
      'stripeTransferGroup': stripeTransferGroup,
      'amount': amount,
      'currency': currency,
      'status': status,
      'paymentUrl': paymentUrl,
      'paidAt': paidAt,
      'transactionId': transactionId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}