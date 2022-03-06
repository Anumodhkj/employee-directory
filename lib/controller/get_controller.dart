import 'dart:developer';
import 'package:get/get.dart';
import 'package:webandcraf/constants/strings.dart';
import 'package:webandcraf/models/employee.dart';
import 'package:webandcraf/service/get_data_service.dart';
import 'package:webandcraf/service/hive_services.dart';

class EmplyeeController extends GetxController {
  final HiveService _hiveService = HiveService();
  var itemListData = <Employee>[].obs;
  var isLoading = false.obs;
  var noData = false.obs;
  var websevice = false.obs;
  @override
  void onInit() {
    getEmployees();
    super.onInit();
  }

  @override
  void dispose() {
    itemListData.close();
    isLoading.close();
    super.dispose();
  }

  getEmployees() async {
    try {
      isLoading(true);
      noData(false);
      websevice(false);
      // Cache
      final dataFromCache =
          await _hiveService.getData<Employee>(Strings.dBname);
      if (dataFromCache.isNotEmpty) {
        log("data is from local database : local database");
        websevice(false);
        itemListData.value = dataFromCache;
      } else {
        var data = await Service.itemList();
        if (data != null) {
          if (data.isNotEmpty) {
            log("data is from online database : web service ");
            await _hiveService.deleteData<Employee>(Strings.dBname);
            await _hiveService.saveData<Employee>(data, Strings.dBname);
            itemListData.value = data;
            noData(false);
            websevice(true);
            log("API call success");
          }
          if (data.isEmpty) {
            itemListData.value = data;
            noData(true);
            websevice(true);
            log("API call success , but not data [] ");
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
