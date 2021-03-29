// To parse this JSON data, do
//
//     final idNumber = idNumberFromJson(jsonString);

import 'dart:convert';

IdNumber idNumberFromJson(String str) => IdNumber.fromJson(json.decode(str));

String idNumberToJson(IdNumber data) => json.encode(data.toJson());

class IdNumber {
  IdNumber({
    this.id,
    this.name,
    this.number,
  });

  String id;
  String name;
  String number;

  factory IdNumber.fromJson(Map<String, dynamic> json) => IdNumber(
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
