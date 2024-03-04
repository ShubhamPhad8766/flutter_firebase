// ignore_for_file: avoid_unnecessary_containers, unnecessary_new, non_constant_identifier_names

import 'package:crud_3/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class EmpScreen extends StatefulWidget {
  const EmpScreen({super.key});

  @override
  State<EmpScreen> createState() => _EmpScreenState();
}

class _EmpScreenState extends State<EmpScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locatonController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Employee",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Form",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      body: Container(
          margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Age",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: ageController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const Text(
                "Location",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: locatonController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      String Id = randomAlphaNumeric(10);
                      Map<String, dynamic> employeeInfoMap = {
                        "Name": nameController.text,
                        "Id": Id,
                        "Age": ageController.text,
                        "Location": locatonController.text
                      };
                      await DataBaseMethod()
                          .addEmpDetails(employeeInfoMap, Id)
                          .then((value) {
                        Fluttertoast.showToast(
                            msg: "Employee Details Added SuccessFully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          )),
    );
  }
}
