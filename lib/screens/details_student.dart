import 'package:flutter/material.dart';
import 'package:main_project_hive/widgets/button_rounded.dart';
import 'package:main_project_hive/widgets/details.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class DetailsStudent extends StatelessWidget {
  DetailsStudent({Key? key}) : super(key: key);
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
              editStudent(context);
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
            children: const [
              SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  radius: 60,
                ),
              ),
              SizedBox(height: 30),
              Details(labeltext: 'Name : Akmal'),
              Details(labeltext: 'Age : 19'),
              Details(labeltext: 'Email : akmalmahmookinan@gmail.com'),
              Details(labeltext: 'Ph : 8138845540'),
            ],
          ),
        ),
      ),
    );
  }

  void editStudent(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
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
                      onpress: () {},
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
