import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:webandcraf/constants/base.dart';
import 'package:webandcraf/models/employee.dart';

class Service {
  static final client = http.Client();
  static  itemList() async {
    final uri = Uri.parse(Base.baseURL);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      log("200");
      final jsonString = response.body;
      final json1 =json.decode(jsonString) as List;
      log(jsonString);
      return json1.map((e) => Employee.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
