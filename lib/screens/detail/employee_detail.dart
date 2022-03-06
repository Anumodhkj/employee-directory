import 'package:flutter/material.dart';
import 'package:webandcraf/constants/colors.dart';
import 'package:webandcraf/constants/strings.dart';
import 'package:webandcraf/models/employee.dart';

class EmpolyeeDetails extends StatelessWidget {
  final Employee employeeList;
  const EmpolyeeDetails({Key? key, required this.employeeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget data(title, datas) {
      return Container(
        width: width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 35,
                child: Text(
                  title ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            Flexible(
                flex: 20,
                child: SizedBox(
                  width: width * 0.5,
                  child: Text(
                    datas ?? "",
                    textAlign: TextAlign.start,
                  ),
                )),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.only(left: 15),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: BrandColors.searchbar,
                  borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: BrandColors.iconAndText,
                  )),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: width,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          employeeList.profile_image != null
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                    employeeList.profile_image.toString(),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(0, 226, 226, 226),
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  child: Center(
                                    child: Text(
                                      Strings.noImage,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                          Text(
                            employeeList.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            employeeList.email,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          data(Strings.username, employeeList.username),
                          data(Strings.phone, employeeList.phone),
                          data(
                              Strings.website,
                              employeeList.website != null
                                  ? employeeList.website.toString()
                                  : ""),
                          Container(
                            width: width,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            child: const Text(
                              Strings.address,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          data(Strings.street, employeeList.address.street),
                          data(Strings.suite, employeeList.address.suite),
                          data(Strings.city, employeeList.address.city),
                          data(Strings.zipcode, employeeList.address.zipcode),
                          Container(
                            width: width,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            child: const Text(
                              Strings.company,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          data(Strings.companyname,
                              employeeList.company!.name.toString()),
                          data(Strings.catchPhrase,
                              employeeList.company!.catchPhrase.toString()),
                          data(Strings.bs, employeeList.company!.bs.toString()),
                        ],
                      )),
                ],
              )),
        ));
  }
}
