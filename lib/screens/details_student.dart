import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/widgets/button_rounded.dart';
import 'package:main_project_hive/widgets/details.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class DetailsStudent extends StatefulWidget {
  DetailsStudent({
    Key? key,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.studebtBox,
    required this.id,
  }) : super(key: key);

  Box<Student> studebtBox;

  final String name;
  final String age;
  final String email;
  final String phone;
  final int id;

  @override
  State<DetailsStudent> createState() => _DetailsStudentState();
}

class _DetailsStudentState extends State<DetailsStudent> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
        actions: [
          IconButton(
            onPressed: () {
              editStudentPressed(context);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  radius: 60,
                ),
              ),
              SizedBox(height: 30),
              Details(
                labeltext: 'Name : ${widget.name}',
              ),
              Details(
                labeltext: 'Age : ${widget.age}',
              ),
              Details(
                labeltext: 'Email : ${widget.email}',
              ),
              Details(
                labeltext: 'Ph : ${widget.phone}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editStudentPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    TextInputField(
                      icon: Icons.person,
                      hintText: "Name",
                      controller: _nameController,
                    ),
                    TextInputField(
                      icon: Icons.numbers,
                      hintText: "Age",
                      controller: _ageController,
                    ),
                    TextInputField(
                      icon: Icons.email,
                      hintText: "Email",
                      controller: _emailController,
                    ),
                    TextInputField(
                      icon: Icons.phone,
                      hintText: "Phone number",
                      controller: _phoneController,
                    ),
                    ButtonRounded(
                      buttonText: "Edit Student",
                      onpress: () {
                        editStudent(widget.studebtBox, ctx, widget.id);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> editStudent(
      Box<Student> studentBox, BuildContext context, int id) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    if (age.isEmpty || name.isEmpty || email.isEmpty || phone.isEmpty) {
      return;
    }
    final _student = Student(name: name, age: age, email: email, phone: phone);
    await widget.studebtBox.put(id, _student);
    print(_student);
    Navigator.pop(context);
  }
}
