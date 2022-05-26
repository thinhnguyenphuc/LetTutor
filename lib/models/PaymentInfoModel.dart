// To parse this JSON data, do
//
//     final paymentInfo = paymentInfoFromJson(jsonString);

import 'dart:convert';

import 'BookingInfoModel.dart';

PaymentInfo paymentInfoFromJson(String str) =>
    PaymentInfo.fromJson(json.decode(str));

String paymentInfoToJson(PaymentInfo data) => json.encode(data.toJson());

class PaymentInfo {
  PaymentInfo({
    required this.id,
    required this.walletId,
    required this.bookingId,
    required this.price,
    required this.revenue,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingInfo,
  });

  final String id;
  final String walletId;
  final String bookingId;
  final String price;
  final String revenue;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BookingInfo bookingInfo;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        id: json["id"],
        walletId: json["walletId"],
        bookingId: json["bookingId"],
        price: json["price"],
        revenue: json["revenue"],
        status: json["status"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookingInfo: BookingInfo.fromJson(json["bookingInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "walletId": walletId,
        "bookingId": bookingId,
        "price": price,
        "revenue": revenue,
        "status": status,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "bookingInfo": bookingInfo.toJson(),
      };
}
