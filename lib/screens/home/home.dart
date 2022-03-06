import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webandcraf/constants/strings.dart';
import 'package:webandcraf/controller/get_controller.dart';
import 'package:webandcraf/helper/helper.dart';
import 'package:webandcraf/models/employee.dart';
import 'package:webandcraf/screens/detail/employee_detail.dart';
import 'package:webandcraf/screens/home/widget/searchbar.dart';
import 'package:webandcraf/service/hive_services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EmplyeeController employeeController = Get.put(EmplyeeController());
  final TextEditingController controller = TextEditingController();
  final HiveService _hiveService = HiveService();
  List<Employee> employeeList = [];
  List<Employee> searchEmployee = [];
  String? searchWord;
  @override
  void initState() {
    super.initState();
  }

  onSearchTextChanged(String text) async {
    searchEmployee = [];
    controller.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (int i = 0; i < employeeList.length; i++) {
      if (employeeList[i].name.toString().contains(text)) {
        searchEmployee.add(employeeList[i]);
      }
    }
    setState(() {});
  }

  deleteDatabase() async {
    DialogHelper.showFastmsg(Strings.titleWarning, Strings.msgWarining);
    await _hiveService.deleteData<Employee>(Strings.dBname);
    employeeController.getEmployees();
    setState(() {});
    DialogHelper.showFastmsg(Strings.infoTitle, Strings.inform);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String statusOFdata = "";
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: SizedBox(
              width: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black,
                    height: 3,
                    width: 10,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    color: Colors.black,
                    height: 3,
                    width: 20,
                  ),
                ],
              )),
          actions: [
            IconButton(
                tooltip: Strings.reloadData,
                onPressed: () async {
                  setState(() {
                    employeeController.getEmployees();
                  });
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.black,
                )),
            IconButton(
                tooltip: Strings.tooltip,
                onPressed: () async => deleteDatabase(),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ))
          ],
        ),
        body: SafeArea(
          child: Obx((() {
            employeeList = [];
            if (employeeController.itemListData.isNotEmpty) {
              employeeList = employeeController.itemListData;
              employeeController.websevice.value
                  ? statusOFdata = Strings.online
                  : statusOFdata = Strings.offline;
              log(employeeList.toString());
            }
            return employeeController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: width,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              Strings.title + statusOFdata,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SearchBar(
                            onTap: () {},
                            onChanged: (value) {
                              setState(() {
                                searchWord = value;
                                log(searchWord.toString());
                                onSearchTextChanged(searchWord!);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          searchEmployee.isNotEmpty ||
                                  controller.text.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, int index) {
                                        return ListTile(
                                          onTap: () => Get.to(EmpolyeeDetails(
                                            employeeList: searchEmployee[index],
                                          )),
                                          leading: searchEmployee[index]
                                                      .profile_image !=
                                                  null
                                              ? CircleAvatar(
                                                  radius: 20.0,
                                                  backgroundImage: NetworkImage(
                                                      searchEmployee[index]
                                                          .profile_image
                                                          .toString()),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          0, 226, 226, 226),
                                                )
                                              : CircleAvatar(
                                                  radius: 20.0,
                                                  child: Center(
                                                    child: Text(
                                                      Strings.noImage,
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                          title: Text(
                                            searchEmployee[index]
                                                .name
                                                .toString(),
                                          ),
                                          subtitle:
                                              searchEmployee[index].company !=
                                                      null
                                                  ? Text(
                                                      searchEmployee[index]
                                                          .company!
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  : Text(
                                                      Strings.noMentioned,
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                        );
                                      },
                                      separatorBuilder: (context, int index) {
                                        return const SizedBox(height: 10);
                                      },
                                      itemCount: searchEmployee.length),
                                )
                              : Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, int index) {
                                        return ListTile(
                                          onTap: () => Get.to(EmpolyeeDetails(
                                            employeeList: employeeList[index],
                                          )),
                                          leading: employeeList[index]
                                                      .profile_image !=
                                                  null
                                              ? CircleAvatar(
                                                  radius: 20.0,
                                                  backgroundImage: NetworkImage(
                                                      employeeList[index]
                                                          .profile_image
                                                          .toString()),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          0, 226, 226, 226),
                                                )
                                              : CircleAvatar(
                                                  radius: 20.0,
                                                  child: Center(
                                                    child: Text(
                                                      Strings.noImage,
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                          title: Text(
                                            employeeList[index].name.toString(),
                                          ),
                                          subtitle:
                                              employeeList[index].company !=
                                                      null
                                                  ? Text(
                                                      employeeList[index]
                                                          .company!
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  : Text(
                                                      Strings.noMentioned,
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                        );
                                      },
                                      separatorBuilder: (context, int index) {
                                        return const SizedBox(height: 10);
                                      },
                                      itemCount: employeeList.length),
                                )
                        ]),
                  );
          })),
        ));
  }
}
