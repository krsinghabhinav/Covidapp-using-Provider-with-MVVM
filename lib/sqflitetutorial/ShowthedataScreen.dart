import 'package:covidapp/sqflitetutorial/db_helper.dart';
import 'package:covidapp/sqflitetutorial/sqflite_Model_Class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShowthedataScreen extends StatefulWidget {
  const ShowthedataScreen({super.key});

  @override
  State<ShowthedataScreen> createState() => _ShowthedataScreenState();
}

class _ShowthedataScreenState extends State<ShowthedataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Data'),
      ),
      body: FutureBuilder(
          future: DataBaseHandler().readData(),
          builder: (context, AsyncSnapshot<List<SqfliteModelClass>> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(snapshot.data![index].id.toString()),
                    ),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].age.toString()),
                  );
                });
          }),
    );
  }
}
