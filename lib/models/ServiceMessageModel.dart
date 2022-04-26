import 'dart:convert';

ServiceMessage serviceMessageFromJson(String str) =>
    ServiceMessage.fromJson(json.decode(str));

String serviceMessageToJson(ServiceMessage data) => json.encode(data.toJson());

class ServiceMessage {
  ServiceMessage({
    required this.statusCode,
    required this.message,
  });

  final int statusCode;
  final String message;

  factory ServiceMessage.fromJson(Map<String, dynamic> json) => ServiceMessage(
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
      };
}
