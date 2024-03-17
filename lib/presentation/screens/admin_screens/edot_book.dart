import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class EditBook extends StatefulWidget {
  EditBook({Key? key, required this.snapshot}) : super(key: key);
  final DocumentSnapshot snapshot;

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  String _bookName = '';

  String _authorName = '';

  String _bookDescription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
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
        ],
      ),
    );
  }
}
