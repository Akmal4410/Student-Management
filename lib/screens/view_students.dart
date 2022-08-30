import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/screens/add_students.dart';
import 'package:main_project_hive/screens/details_student.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({Key? key}) : super(key: key);

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  final _searchController = TextEditingController();
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

  final studentBoxList = Hive.box('Student').values.toList();
  late List displayStudent = List<Student>.from(studentBoxList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            TextInputField(
              icon: Icons.search,
              hintText: "Search Names",
              controller: _searchController,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentBox!.listenable(),
                builder: (BuildContext context, Box<Student> studenstList,
                    Widget? child) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final key = studenstList.keys.toList()[index];
                      final student = studenstList.get(key);
                      return ListTile(
                        leading: const CircleAvatar(),
                        title: Text(student!.name),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (conntext) => DetailsStudent()));
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: studenstList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AddStudent(studentBox: studentBox!),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
