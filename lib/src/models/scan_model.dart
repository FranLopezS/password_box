// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ScanModel welcomeFromJson(String str) => ScanModel.fromJson(json.decode(str));

String welcomeToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    String platform;
    String name;
    String passwd;

    ScanModel({
        this.platform,
        this.name,
        this.passwd,
    });

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        platform  : json["platform"],
        name      : json["name"],
        passwd    : json["passwd"],
    );

    Map<String, dynamic> toJson() => {
        "platform"  : platform,
        "name"      : name,
        "passwd"    : passwd,
    };
}
