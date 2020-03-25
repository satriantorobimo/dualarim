import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'waktu_sholat_model.g.dart';

@JsonSerializable()
class WaktuSholatModel {
  String nama;
  String waktu;
  String display;

  WaktuSholatModel({this.nama, this.waktu, this.display});

  factory WaktuSholatModel.fromJson(Map<String, dynamic> json) =>
      _$WaktuSholatModelFromJson(json);
  Map<String, dynamic> toJson() => _$WaktuSholatModelToJson(this);
}
