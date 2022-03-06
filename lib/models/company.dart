import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Company {
    Company({
       required this.name,
      required  this.catchPhrase,
      required  this.bs,
    });

    @HiveField(0)
    String name;
    @HiveField(1)
    String catchPhrase;
    @HiveField(2)
    String bs;

  
  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

 
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
