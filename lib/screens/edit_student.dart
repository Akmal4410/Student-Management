import 'package:flutter/material.dart';
import 'package:main_project_hive/widgets/button_rounded.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class EditStudent extends StatelessWidget {
  EditStudent({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

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
                const Center(
                  child: CircleAvatar(
                    // backgroundImage: (image != null)
                    //     ? FileImage(image!)
                    //     : AssetImage("assets/image/avatar.jpeg")
                    //         as ImageProvider,
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
                        // addPhoto();
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
              onpress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
