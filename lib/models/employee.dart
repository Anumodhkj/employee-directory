import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webandcraf/models/address.dart';
import 'package:webandcraf/models/company.dart';

part 'employee.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Employee {
  Employee({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.profile_image,
    required this.address,
    required this.phone,
    this.website,
    this.company,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String username;
  @HiveField(3)
  String email;
  @HiveField(4)
  String? profile_image;
  @HiveField(5)
  Address address;
  @HiveField(6)
  dynamic phone;
  @HiveField(7)
  String? website;
  @HiveField(8)
  Company? company;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
