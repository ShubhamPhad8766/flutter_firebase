// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_3/screens/emp.dart';
import 'package:crud_3/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? EmployeeStream;
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locatonController = new TextEditingController();
  getontheload() async {
    EmployeeStream = await DataBaseMethod().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
      stream: EmployeeStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Name : " + ds["Name"],
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    nameController.text = ds["Name"];
                                    ageController.text = ds["Age"];
                                    locatonController.text = ds["Location"];
                                    EditEmployeeDetails(ds["Id"]);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await DataBaseMethod()
                                        .deleteEmployeeDetails(
                                      ds["Id"]
                                    );
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Age :" + ds["Age"],
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Location :" + ds["Location"],
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmpScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title:
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Flutter",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Firebase",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(child: allEmployeeDetails()),
        ],
      )),
    );
  }

  Future EditEmployeeDetails(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel)),
                    const SizedBox(
                      width: 60.0,
                    ),
                    const Text(
                      "Edit",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Dtails",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 20.0,
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
                      fontSize: 20.0,
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
                      fontSize: 20.0,
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
                  height: 30,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateInfo = {
                            "Name": nameController.text,
                            "Age": ageController.text,
                            "Id": id,
                            "Location": locatonController.text
                          };
                          await DataBaseMethod()
                              .updateEmployeeDetails(id, updateInfo)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Update")))
              ],
            ),
          ),
        ),
      );
}
