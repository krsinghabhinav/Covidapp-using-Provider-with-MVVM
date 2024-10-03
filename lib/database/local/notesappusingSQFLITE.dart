import 'package:covidapp/database/local/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notesappusingsqflite extends StatefulWidget {
  const Notesappusingsqflite({super.key});

  @override
  State<Notesappusingsqflite> createState() => _NotesappusingsqfliteState();
}

class _NotesappusingsqfliteState extends State<Notesappusingsqflite> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = DBHelper.getInstance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
      ),
      body: allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                  subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          titleController.text =
                              allNotes[index][DBHelper.COLUMN_NOTE_TITLE];
                          descController.text =
                              allNotes[index][DBHelper.COLUMN_NOTE_DESC];

                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: BottomShowView(
                                  isUpdate: true,
                                  sno: allNotes[index]
                                      [DBHelper.COLUMN_NOTE_S_NO],
                                ),
                              );
                            },
                          );
                          Get.back();
                          titleController.clear();
                          descController.clear();
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(child: Text("No notes yet!!!!!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          descController.clear();

          showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: BottomShowView(),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Container BottomShowView({bool isUpdate = false, int sno = 0}) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isUpdate ? "Update Notes" : "Add Notes",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Enter Title",
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Enter Description",
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        var title = titleController.text.trim();
                        var desc = descController.text.trim();

                        if (title.isNotEmpty && desc.isNotEmpty) {
                          bool? check = isUpdate
                              ? await dbRef!.getUpdateNotes(
                                  mtitle: title, mdesc: desc, sno: sno)
                              : await dbRef!
                                  .addData(mtitle: title, mdesc: desc);

                          if (check!) {
                            getNotes();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Data Added Successfully")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to Add Data")),
                            );
                          }
                        }
                        Get.back();
                        titleController.clear();
                        descController.clear();
                      },
                      child: Text(isUpdate ? "Update Notes" : "Add Notes"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Cancel"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
