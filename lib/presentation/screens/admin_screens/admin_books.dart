import 'package:bookly/presentation/screens/admin_screens/edot_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Features/home/presentation/views/widgets/custom_book_item.dart';
import '../../../constants.dart';
import '../../../core/utils/styles.dart';

class AdminBooks extends StatefulWidget {
  const AdminBooks({Key? key}) : super(key: key);

  @override
  State<AdminBooks> createState() => _AdminBooksState();
}

class _AdminBooksState extends State<AdminBooks> {
  String _bookName = '';
  String _authorName = '';
  String _bookDescription = '';

  Future<void> _deleteBook(
      BuildContext context, DocumentReference documentReference) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.delete(documentReference);
        await transaction.delete(documentReference);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete book')),
      );
    }
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, DocumentSnapshot documentSnapshot) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure, do you want to delete book?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Yes',
              ),
              onPressed: () async {
                try {
                  await _deleteBook(context, documentSnapshot.reference);
                  Navigator.pop(context);
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Book deleted successfully')),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Authentication Failed')),
                  );
                }
                // Close the dialog
              },
            ),
            TextButton(
              child: const Text(
                'No',
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'All Books',
          style: TextStyle(
              color: Color(0xfffbf4ea),
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('books').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator(); // Display loading indicator
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Row(
                            children: [
                              CustomBookImage(imageUrl: data['bookCover']),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: Text(
                                        "${data['bookName']}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.textStyle30.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        // textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Opacity(
                                        opacity: .7,
                                        child: Row(
                                          children: [
                                            Text(
                                              data['authorName'],
                                              style:
                                                  Styles.textStyle18.copyWith(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Opacity(
                                      opacity: .7,
                                      child: Text(
                                        data['bookDescription'] ?? '',
                                        maxLines: 3,
                                        style: Styles.textStyle20.copyWith(
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis
                                            // fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // mainAxisAlignment:
                                      // MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                builder: (context) {
                                                  return SingleChildScrollView(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 8,
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(
                                                              height: 20),
                                                          TextField(
                                                            onChanged:
                                                                (value) =>
                                                                    _bookName =
                                                                        value,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xfffbf4ea),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            decoration:
                                                                InputDecoration(
                                                                    // labelText:
                                                                    //     'Book Name',
                                                                    hintText: data[
                                                                        'bookName'],
                                                                    focusColor:
                                                                        kPrimaryColor,
                                                                    focusedBorder: const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color: Color(
                                                                                0xfffbf4ea))),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Color(
                                                                                0xfffbf4ea)),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12))),
                                                            // decoration: const InputDecoration(
                                                            //   labelText: 'Author Name',
                                                            //   border: OutlineInputBorder(),
                                                            // ),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          TextField(
                                                            onChanged: (value) =>
                                                                _authorName =
                                                                    value,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xfffbf4ea),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            decoration:
                                                                InputDecoration(
                                                                    // labelText:
                                                                    //     'Author Name',
                                                                    hintText: data[
                                                                        'authorName'],
                                                                    focusColor:
                                                                        kPrimaryColor,
                                                                    focusedBorder: const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color: Color(
                                                                                0xfffbf4ea))),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Color(
                                                                                0xfffbf4ea)),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12))),
                                                            // decoration: const InputDecoration(
                                                            //   labelText: 'Author Name',
                                                            //   border: OutlineInputBorder(),
                                                            // ),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          TextField(
                                                            onChanged: (value) =>
                                                                _bookDescription =
                                                                    value,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xfffbf4ea),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText: data[
                                                                        'bookDescription'],
                                                                    // labelText:
                                                                    //     'Book Description',
                                                                    focusColor:
                                                                        kPrimaryColor,
                                                                    focusedBorder: const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color: Color(
                                                                                0xfffbf4ea))),
                                                                    border: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color: Color(
                                                                                0xfffbf4ea)),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12))),
                                                            // decoration: const InputDecoration(
                                                            //   labelText: 'Author Name',
                                                            //   border: OutlineInputBorder(),
                                                            // ),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          InkWell(
                                                            onTap: () async {
                                                              try {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .runTransaction(
                                                                        (transaction) {
                                                                  return document
                                                                      .reference
                                                                      .update({
                                                                    'bookName': _bookName
                                                                            .isEmpty
                                                                        ? data[
                                                                            'bookName']
                                                                        : _bookName,
                                                                    'authorName': _authorName
                                                                            .isEmpty
                                                                        ? data[
                                                                            'authorName']
                                                                        : _authorName,
                                                                    'bookDescription': _bookDescription
                                                                            .isEmpty
                                                                        ? data[
                                                                            'bookDescription']
                                                                        : _bookDescription
                                                                  });
                                                                });

                                                                // document
                                                                //     .reference
                                                                //     .update({
                                                                //   'bookName':
                                                                //       _bookName,
                                                                //   'authorName':
                                                                //       _authorName,
                                                                //   'bookDescription':
                                                                //       _bookDescription
                                                                // });
                                                                Navigator.pop(
                                                                    context);
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .green,
                                                                        content:
                                                                            Text(
                                                                          "Book updated successfully!",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )));
                                                                // setState(() {
                                                                //   isLoading =
                                                                //       false;
                                                                // });
                                                              } catch (e) {
                                                                print('e');
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              width: 200,
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xfffbf4ea),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "Update Book",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          kPrimaryColor),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                isScrollControlled: true,
                                                context: context);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             EditBook(
                                            //               snapshot: document,
                                            //             )));
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: const Color(0xfffbf4ea),
                                                //
                                                // color: Colors
                                                //     .deepOrangeAccent.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: Text(
                                                "Edit",
                                                style: Styles.textStyle20
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kPrimaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        InkWell(
                                          onTap: () {
                                            _showDeleteConfirmationDialog(
                                                context, document);
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                //
                                                // color: Colors
                                                //     .deepOrangeAccent.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: Text(
                                                "Delete",
                                                style: Styles.textStyle20
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xfffbf4ea)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Divider(
                          endIndent: 30,
                          indent: 30,
                          thickness: 1,
                          height: 1,
                          color: Colors.white,
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
