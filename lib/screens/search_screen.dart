import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  final List<Student> studentBoxList =
      Hive.box<Student>('Student').values.toList();

  late List<Student> displayStudent = List<Student>.from(studentBoxList);

  void searchStudentList(String value) {
    setState(() {
      displayStudent = studentBoxList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 245, 237, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(173, 194, 169, 1),
        title: const Text("Search Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            TextInputField(
              icon: Icons.search,
              hintText: "Search Names",
              controller: _searchController,
              onChanged: (value) {
                searchStudentList(value);
              },
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(),
                    title: Text(displayStudent[index].name),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: displayStudent.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}