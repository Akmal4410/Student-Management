import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/screens/view_students.dart';
import 'package:main_project_hive/widgets/button_rounded.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class EditStudent extends StatefulWidget {
  final Student student;
  final Box<Student> studentBox;
  const EditStudent({Key? key, required this.student, required this.studentBox})
      : super(key: key);

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;

  String? imagePath;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age);
    _emailController = TextEditingController(text: widget.student.email);
    _phoneController = TextEditingController(text: widget.student.phone);
    imagePath = widget.student.image;
    super.initState();
  }

  Future<void> updatePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      imagePath = image.path;
    });
  }

  Future<void> editStudent() async {
    final name = _nameController!.text;
    final age = _ageController!.text;
    final email = _emailController!.text;
    final phone = _phoneController!.text;
    if (name.isEmpty || age.isEmpty || email.isEmpty || phone.isEmpty) {
      return;
    }
    final _student = Student(
        name: name, age: age, email: email, phone: phone, image: imagePath!);
    await widget.studentBox.put(widget.student.key, _student);

    showEditedAlertBox(context);
  }

  void showEditedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Column(
              children: const [Text("Student Editd"), Divider()],
            ),
            content: const Text("Student edited successfully to the database"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      ctx,
                      MaterialPageRoute(builder: (ctx) => const ViewStudents()),
                      (route) => false);
                  // Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 245, 237, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(173, 194, 169, 1),
        title: const Text("Edit Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: (imagePath != null)
                        ? FileImage(File(imagePath!))
                        : const AssetImage("assets/image/avatar.jpeg")
                            as ImageProvider,
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
                      color: Color.fromRGBO(173, 194, 169, 1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        updatePhoto();
                      },
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
              hintText: 'Name',
              controller: _nameController!,
            ),
            TextInputField(
              icon: Icons.numbers,
              hintText: 'Age',
              controller: _ageController!,
            ),
            TextInputField(
              icon: Icons.email,
              hintText: 'Email',
              controller: _emailController!,
            ),
            TextInputField(
              icon: Icons.phone,
              hintText: 'Phone',
              controller: _phoneController!,
            ),
            ButtonRounded(
              buttonText: "Edit Student",
              onpress: () {
                editStudent();
              },
            ),
          ],
        ),
      ),
    );
  }
}
