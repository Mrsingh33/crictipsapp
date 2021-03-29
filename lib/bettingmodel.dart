// To parse this JSON data, do
//
//     final bettingNumber = bettingNumberFromJson(jsonString);

import 'dart:convert';

BettingNumber bettingNumberFromJson(String str) => BettingNumber.fromJson(json.decode(str));

String bettingNumberToJson(BettingNumber data) => json.encode(data.toJson());

class BettingNumber {
  BettingNumber({
    this.id,
    this.name,
    this.number,
  });

  String id;
  String name;
  String number;

  factory BettingNumber.fromJson(Map<String, dynamic> json) => BettingNumber(
    id: json["id"],
    name: json["name"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "number": number,
  };
}
