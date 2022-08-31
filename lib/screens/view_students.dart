import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/screens/add_students.dart';
import 'package:main_project_hive/screens/details_student.dart';
import 'package:main_project_hive/screens/edit_student.dart';
import 'package:main_project_hive/screens/search_screen.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({Key? key}) : super(key: key);

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  Box<Student>? studentBox;

  @override
  void initState() {
    studentBox = Hive.box<Student>('Student');
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 245, 237, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(173, 194, 169, 1),
        title: const Text("View Students"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentBox!.listenable(),
                builder: (BuildContext context, Box<Student> studenstList,
                    Widget? child) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: studenstList.length,
                    itemBuilder: (context, index) {
                      final key = studenstList.keys.toList()[index];
                      final student = studenstList.get(key);
                      File imageFile = File(student!.image);
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (conntext) =>
                                  DetailsStudent(student: student),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(imageFile),
                        ),
                        title: Text(student.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditStudent(
                                              student: student,
                                              studentBox: studentBox!,
                                            )));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromRGBO(173, 194, 169, 1),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                studenstList.delete(student.key);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromRGBO(173, 194, 169, 1),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(173, 194, 169, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AddStudent(studentBox: studentBox!),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
