import 'package:covidapp/sqflitetutorial/ShowthedataScreen.dart';
import 'package:covidapp/sqflitetutorial/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sqflite_Model_Class.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DataBaseHandler dbHandler = DataBaseHandler();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqf LiteDataBase"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: "Enter age",
                border: OutlineInputBorder(),
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  setState(() async {
                    // await dbHandler.insertData(30, 'aksingj', 20);

                    await dbHandler.insertData(
                      SqfliteModelClass(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                      ),
                    );
                    print("data is inserted");
                  });
                },
                child: Text("Insert Data")),

            // ElevatedButton(
            //   onPressed: ()async {
            //       final data = await dbHandler.readData();
            //     setState(()  {
            //       // Read data
            //       // List<Map<String, dynamic>> data =
            //       //     await dbHandler.readData();
            //       // print(data);

            //       // final data = await dbHandler.readData();
            //       // print(data);

            //       // List<Map<String, dynamic>>
            //       print(data[5].id);
            //     });
            //     // Insert data
            //   },
            //   child: Text("Read Data"),
            // ),

            ElevatedButton(
              onPressed: () async {
                final data = await dbHandler.readData();
                setState(() {
                  print(data[11].name);
                  print("read the data");
                });
              },
              child: Text("Read Data"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() async {
                  DataBaseHandler().deleteData(6);
                  List<SqfliteModelClass> data = await dbHandler.readData();
                  print(data);
                });
                // Insert data
              },
              child: Text("Delete Data"),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() async {
                    // Update data
                    await DataBaseHandler().updateData(SqfliteModelClass(
                        id: 10, name: "aaaaaaaaaaaaaaaaaaaa", age: 20));
                    print("data updated");
                  });

                  // Insert data
                },
                child: Text("Update Data")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ShowthedataScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
