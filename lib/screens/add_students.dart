import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/widgets/button_rounded.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key, required this.studentBox}) : super(key: key);

  Box<Student> studentBox;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> addStudent(Box<Student> studentBox, BuildContext context) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    if (age.isEmpty || name.isEmpty || email.isEmpty || phone.isEmpty) {
      return;
    }
    final _student = Student(name: name, age: age, email: email, phone: phone);
    await studentBox.add(_student);
    print(_student);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Stack(
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 60,
                  ),
                ),
                Positioned(
                  top: 65,
                  left: 210,
                  child: Container(
                    height: 40,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_upward_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
              buttonText: "Add Student",
              onpress: () {
                addStudent(studentBox, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
