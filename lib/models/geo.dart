
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Geo {
    Geo({
      required  this.lat,
      required  this.lng,
    });
    @HiveField(0)
    String lat;
    @HiveField(1)
    String lng;

   
  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);
}