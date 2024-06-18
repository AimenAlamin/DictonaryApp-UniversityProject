import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_18/sqldb.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController engWordController = TextEditingController();
  final TextEditingController turWordController = TextEditingController();
  File? _image;

  final SqlDb sqlDb = SqlDb(); // Create an instance of SqlDb

  @override
  void dispose() {
    engWordController.dispose();
    turWordController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> insertWord() async {
    String engWord = engWordController.text.trim();
    String turWord = turWordController.text.trim();
    if (_image != null) {
      List<int> imageBytes = await _image!.readAsBytes();
      int insertResponse = await sqlDb.insertData(engWord, turWord, imageBytes);
      print(insertResponse); // Print the response for debugging
    } else {
      // Handle the case where no image is selected
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Page",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        // color: Color.fromARGB(255, 21, 31, 39),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextField(
              controller: engWordController,
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                labelText: "English Word",
                hintText: "Enter English Word",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: turWordController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                  fontSize: 20,
                  //color: Colors.white,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                labelText: "Turkish Word",
                labelStyle: const TextStyle(fontSize: 23),
                hintText: "Enter Turkish Word",
                hintStyle: const TextStyle(fontSize: 10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: pickImage,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Upload Image",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.image),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_image != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(_image!),
              ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: insertWord,
              //color: Color.fromARGB(255, 40, 51, 83),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: const Text(
                "ADD",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
