import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../../constants.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  File? _image;
  File? _pdf;
  String _bookName = '';
  String _authorName = '';
  String _bookDescription = '';
  bool isLoading = false;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    setState(() {
      if (result != null) {
        _pdf = File(result.files.single.path!);
      } else {
        print('No PDF selected.');
      }
    });
  }

  Future<void> uploadToFirebase() async {
    if (_image == null ||
        _pdf == null ||
        _bookName.isEmpty ||
        _authorName.isEmpty ||
        _bookDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //backgroundColor: Color(0xfffbf4ea),
          backgroundColor: Colors.red,
          content: Text(
            'Complete All Fields!',
            style: TextStyle(
                color: Color(0xfffbf4ea),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )));
      return;
    }
    setState(() {
      isLoading = true;
    });
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String imageFileName = 'images/${DateTime.now()}.png';
    final String pdfFileName = 'pdfs/${DateTime.now()}.pdf';

    try {
      await storage.ref(imageFileName).putFile(
            _image!,
            SettableMetadata(contentType: 'image/jpeg'),
          );
      await storage.ref(pdfFileName).putFile(
            _pdf!,
            SettableMetadata(
              contentType: 'application/pdf',
            ),
          );

      // Get the download URLs for both files
      final imageUrl = await storage.ref(imageFileName).getDownloadURL();
      final pdfUrl = await storage.ref(pdfFileName).getDownloadURL();
      FirebaseFirestore.instance.collection('books').doc().set({
        'authorName': _authorName,
        'bookName': _bookName,
        'bookDescription': _bookDescription,
        'bookCover': imageUrl,
        'bookPdf': pdfUrl
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Book pulished successfully!",
            style: TextStyle(color: Colors.white),
          )));
      setState(() {
        isLoading = false;
      });

      // Now you can save these URLs along with book name and author name in Firebase Database or Firestore
      // For simplicity, I'm just printing them here
      print('Image URL: $imageUrl');
      print('PDF URL: $pdfUrl');
      print('Book Name: $_bookName');
      print('Author Name: $_authorName');
    } catch (e) {
      print('Error uploading to Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Book Data'),
      ),
      //        color: Color(0xfffbf4ea),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 24,
            ),
            Container(
                height: 300,
                // width: MediaQuery.of(context).,
                decoration: BoxDecoration(
                    border: const Border(
                        bottom: BorderSide(color: Color(0xfffbf4ea)),
                        top: BorderSide(color: Color(0xfffbf4ea)),
                        left: BorderSide(color: Color(0xfffbf4ea)),
                        right: BorderSide(color: Color(0xfffbf4ea))),
                    borderRadius: BorderRadius.circular(12)),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ))
                    : GestureDetector(
                        // style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
                        onTap: getImage,
                        child: Center(
                            child: const Text(
                          'Pick Cover Image',
                          style:
                              TextStyle(fontSize: 26, color: Color(0xfffbf4ea)),
                        )))),

            // if (_image != null)SizedBox(height: 100,child:  Image.file(_image!)),
            // ElevatedButton(
            //   onPressed: getImage,
            //   child: const Text('Pick Image'),
            // ),
            const SizedBox(height: 20),
            if (_pdf != null)
              Text(
                'PDF Selected: ${_pdf!.path}',
                style: const TextStyle(color: Color(0xfffbf4ea)),
              ),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xfffbf4ea))),
              onPressed: getPdf,
              child: const Text(
                'Pick PDF',
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _bookName = value,
              style: const TextStyle(
                  color: Color(0xfffbf4ea),
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  labelText: 'Book Name',
                  focusColor: kPrimaryColor,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfffbf4ea))),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xfffbf4ea)),
                      borderRadius: BorderRadius.circular(12))),
              // decoration: const InputDecoration(
              //   labelText: 'Author Name',
              //   border: OutlineInputBorder(),
              // ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _authorName = value,
              style: const TextStyle(
                  color: Color(0xfffbf4ea),
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  labelText: 'Author Name',
                  focusColor: kPrimaryColor,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfffbf4ea))),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xfffbf4ea)),
                      borderRadius: BorderRadius.circular(12))),
              // decoration: const InputDecoration(
              //   labelText: 'Author Name',
              //   border: OutlineInputBorder(),
              // ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _bookDescription = value,
              style: const TextStyle(
                  color: Color(0xfffbf4ea),
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  labelText: 'Book Description',
                  focusColor: kPrimaryColor,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfffbf4ea))),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xfffbf4ea)),
                      borderRadius: BorderRadius.circular(12))),
              // decoration: const InputDecoration(
              //   labelText: 'Author Name',
              //   border: OutlineInputBorder(),
              // ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              // width: 100,
              height: 50,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xfffbf4ea))),
                onPressed: uploadToFirebase,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: kPrimaryColor,
                      )
                    : const Text(
                        'Publish Book',
                        style: TextStyle(color: kPrimaryColor, fontSize: 24),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
