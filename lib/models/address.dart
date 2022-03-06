import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webandcraf/models/geo.dart';

part 'address.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Address {
    Address({
      required  this.street,
      required  this.suite,
      required  this.city,
      required  this.zipcode,
      required  this.geo,
    });

    @HiveField(0)
    String street;
    @HiveField(1)
    String suite;
    @HiveField(2)
    String city;
    @HiveField(3)
    String zipcode;
    @HiveField(4)
    Geo geo;

/// factory.
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  /// Connect the generated [_$AddressToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AddressToJson(this);
  
}