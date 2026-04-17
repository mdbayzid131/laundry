class ActiveOrdersResponse {
  final bool? success;
  final String? message;
  final List<ActiveOrder>? data;

  ActiveOrdersResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ActiveOrdersResponse.fromJson(Map<String, dynamic> json) {
    return ActiveOrdersResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<ActiveOrder>.from(
              json['data'].map((x) => ActiveOrder.fromJson(x)),
            )
          : [],
    );
  }
}

class ActiveOrder {
  final String? id;
  final String? orderNumber;
  final String? status;
  final String? paymentStatus;
  final String? totalAmount;
  final String? scheduledDate;
  final String? createdAt;

  final Address? pickupAddress;
  final Address? deliveryAddress;
  final List<OperatorOrder>? operatorOrders;
  final List<OrderItem>? orderItems;
  final Payment? payment;
  final ActiveOrderMetadata? activeOrderMetadata;

  ActiveOrder({
    this.id,
    this.orderNumber,
    this.status,
    this.paymentStatus,
    this.totalAmount,
    this.scheduledDate,
    this.createdAt,
    this.pickupAddress,
    this.deliveryAddress,
    this.operatorOrders,
    this.orderItems,
    this.payment,
    this.activeOrderMetadata,
  });

  factory ActiveOrder.fromJson(Map<String, dynamic> json) {
    return ActiveOrder(
      id: json['id'],
      orderNumber: json['orderNumber'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      totalAmount: json['totalAmount'],
      scheduledDate: json['scheduledDate'],
      createdAt: json['createdAt'],
      pickupAddress: json['pickupAddress'] != null
          ? Address.fromJson(json['pickupAddress'])
          : null,
      deliveryAddress: json['deliveryAddress'] != null
          ? Address.fromJson(json['deliveryAddress'])
          : null,
      operatorOrders: json['operatorOrders'] != null
          ? List<OperatorOrder>.from(
              json['operatorOrders'].map((x) => OperatorOrder.fromJson(x)),
            )
          : [],
      orderItems: json['orderItems'] != null
          ? List<OrderItem>.from(
              json['orderItems'].map((x) => OrderItem.fromJson(x)),
            )
          : [],
      payment:
          json['payment'] != null ? Payment.fromJson(json['payment']) : null,
      activeOrderMetadata: json['activeOrderMetadata'] != null
          ? ActiveOrderMetadata.fromJson(json['activeOrderMetadata'])
          : null,
    );
  }
}

class Address {
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? country;

  Address({
    this.streetAddress,
    this.city,
    this.state,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      streetAddress: json['streetAddress'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }
}

class OperatorOrder {
  final String? id;
  final String? transferStatus;
  final Store? store;
  final Operator? operator;

  OperatorOrder({
    this.id,
    this.transferStatus,
    this.store,
    this.operator,
  });

  factory OperatorOrder.fromJson(Map<String, dynamic> json) {
    return OperatorOrder(
      id: json['id'],
      transferStatus: json['transferStatus'],
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
      operator:
          json['operator'] != null ? Operator.fromJson(json['operator']) : null,
    );
  }
}

class Operator {
  final String? id;
  final OperatorUser? user;

  Operator({
    this.id,
    this.user,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'],
      user:
          json['user'] != null ? OperatorUser.fromJson(json['user']) : null,
    );
  }
}

class OperatorUser {
  final String? name;
  final String? avatar;
  final String? phone;

  OperatorUser({
    this.name,
    this.avatar,
    this.phone,
  });

  factory OperatorUser.fromJson(Map<String, dynamic> json) {
    return OperatorUser(
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
    );
  }
}

class Store {
  final String? id;
  final String? name;
  final String? logo;
  final String? city;

  Store({
    this.id,
    this.name,
    this.logo,
    this.city,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      city: json['city'],
    );
  }
}

class OrderItem {
  final String? id;
  final String? serviceName;
  final int? quantity;
  final String? price;
  final StoreService? storeService;
  final StoreBundle? storeBundle;

  OrderItem({
    this.id,
    this.serviceName,
    this.quantity,
    this.price,
    this.storeService,
    this.storeBundle,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      serviceName: json['serviceName'],
      quantity: json['quantity'],
      price: json['price'],
      storeService: json['storeService'] != null
          ? StoreService.fromJson(json['storeService'])
          : null,
      storeBundle: json['storeBundle'] != null
          ? StoreBundle.fromJson(json['storeBundle'])
          : null,
    );
  }
}

class StoreService {
  final String? id;
  final Service? service;

  StoreService({
    this.id,
    this.service,
  });

  factory StoreService.fromJson(Map<String, dynamic> json) {
    return StoreService(
      id: json['id'],
      service:
          json['service'] != null ? Service.fromJson(json['service']) : null,
    );
  }
}

class Service {
  final String? name;
  final String? image;

  Service({
    this.name,
    this.image,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      image: json['image'],
    );
  }
}

class StoreBundle {
  final String? id;

  StoreBundle({this.id});

  factory StoreBundle.fromJson(Map<String, dynamic> json) {
    return StoreBundle(id: json['id']);
  }
}

class Payment {
  final String? amount;
  final String? status;
  final String? paymentUrl;

  Payment({
    this.amount,
    this.status,
    this.paymentUrl,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      amount: json['amount'],
      status: json['status'],
      paymentUrl: json['paymentUrl'],
    );
  }
}

class ActiveOrderMetadata {
  final int? currentStep;
  final int? totalSteps;
  final String? statusMessage;
  final String? estimatedArrivalTime;
  final Driver? driver;

  ActiveOrderMetadata({
    this.currentStep,
    this.totalSteps,
    this.statusMessage,
    this.estimatedArrivalTime,
    this.driver,
  });

  factory ActiveOrderMetadata.fromJson(Map<String, dynamic> json) {
    return ActiveOrderMetadata(
      currentStep: json['currentStep'],
      totalSteps: json['totalSteps'],
      statusMessage: json['statusMessage'],
      estimatedArrivalTime: json['estimatedArrivalTime'],
      driver:
          json['driver'] != null ? Driver.fromJson(json['driver']) : null,
    );
  }
}

class Driver {
  final String? name;
  final String? avatar;
  final String? phone;
  final double? rating;

  Driver({
    this.name,
    this.avatar,
    this.phone,
    this.rating,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
    );
  }
}