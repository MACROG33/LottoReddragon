// To parse this JSON data, do
//
//     final orderLottoGetResponse = orderLottoGetResponseFromJson(jsonString);

import 'dart:convert';

OrderLottoGetResponse orderLottoGetResponseFromJson(String str) => OrderLottoGetResponse.fromJson(json.decode(str));

String orderLottoGetResponseToJson(OrderLottoGetResponse data) => json.encode(data.toJson());

class OrderLottoGetResponse {
    List<Order> order;
    String message;

    OrderLottoGetResponse({
        required this.order,
        required this.message,
    });

    factory OrderLottoGetResponse.fromJson(Map<String, dynamic> json) => OrderLottoGetResponse(
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
        "message": message,
    };
}

class Order {
    int orderId;
    int userId;
    String orderDate;

    Order({
        required this.orderId,
        required this.userId,
        required this.orderDate,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        userId: json["user_id"],
        orderDate: json["order_date"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "order_date": orderDate,
    };
}
