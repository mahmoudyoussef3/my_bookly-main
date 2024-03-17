import 'package:bookly/constants.dart';
import 'package:bookly/presentation/screens/admin_screens/admin_books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/strings.dart';

// class AddNewBook extends StatefulWidget {
//   const AddNewBook({Key? key}) : super(key: key);
//
//   @override
//   State<AddNewBook> createState() => State<AddNewBook>();
// }
//
// class _AdminHomeScreenState extends State<AddNewBook> {
//   List<bool> activationStates = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeActivationStates();
//   }
//
//   Future<void> _initializeActivationStates() async {
//     QuerySnapshot querySnapshot = await _fireStore.collection('users').get();
//     setState(() {
//       activationStates = querySnapshot.docs
//           .map<bool>((doc) => doc['isActivated'] ?? false)
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             onPressed: () async {
//               try {
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacementNamed(context, loginScreen);
//               } catch (error) {
//                 ScaffoldMessenger.of(context).clearSnackBars();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Authentication Failed')),
//                 );
//               }
//             },
//             icon: const Icon(
//               Icons.logout,
//               color: Colors.red,
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const Text('All Users'),
//             SizedBox(
//               height: 50,
//               child: StreamBuilder(
//                 stream:
//                     FirebaseFirestore.instance.collection('users').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(
//                       child: Text("No Users Found"),
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     return const Center(
//                       child: Text("Something Went Wrong"),
//                     );
//                   }
//                   final loadUsers = snapshot.data!.docs;
//
//                   return ListView.builder(
//                     itemBuilder: (context, index) {
//                       var user = loadUsers[index].data();
//
//                       return Container(
//                         margin: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               height: 100,
//                               width: 200,
//                               child: ListTile(
//                                 title: Text(user['userName']),
//                                 subtitle: Text(user['eMail']),
//                               ),
//                             ),
//                             ElevatedButton(
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.resolveWith<Color>(
//                                   (Set<MaterialState> states) {
//                                     return activationStates[index]
//                                         ? Colors.green
//                                         : Colors.blue;
//                                   },
//                                 ),
//                               ),
//                               onPressed: () {
//                                 _activateAccount(loadUsers[index].id, index);
//                               },
//                               child: Text(
//                                 activationStates[index]
//                                     ? 'Activated'
//                                     : 'Activate',
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     itemCount: loadUsers.length,
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, addNewBook);
//                 },
//                 child: const Text("Add"))
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _activateAccount(String userId, int index) async {
//     try {
//       await _fireStore
//           .collection('users')
//           .doc(userId)
//           .update({'isActivated': true});
//       setState(() {
//         activationStates[index] = true;
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
//
// // class _AddNewBookState extends State<AddNewBook> {
// //   bool completed = false;
// //   TextEditingController bookName = TextEditingController();
// //   TextEditingController authorName = TextEditingController();
// //   final GlobalKey<FormState> _globalKey = GlobalKey();
// //   late FilePickerResult? bookPdf;
// //   bool selectedPdf = false;
// //   bool loaded = false;
// //   Uint8List? _pdfBytes;
// //   Uint8List? _imageBytes;
// //   bool _isLoading = false;
// //   File? pickedImageFile; // Initialize pickedImageFile
// //
// //   void _pickPdf() async {
// //     setState(() {
// //       _isLoading = true;
// //     });
// //
// //     bookPdf = await FilePicker.platform.pickFiles(
// //       type: FileType.custom,
// //       allowedExtensions: ['pdf'],
// //     );
// //
// //     if (bookPdf != null) {
// //       setState(() {
// //         selectedPdf = true;
// //       });
// //       _pdfBytes = bookPdf?.files.single.bytes;
// //     }
// //
// //     setState(() {
// //       _isLoading = false;
// //     });
// //   }
// //
// //   Future<void> _uploadFiles() async {
// //     setState(() {
// //       _isLoading = true;
// //     });
// //
// //     if (_pdfBytes != null && pickedImageFile != null) {
// //       try {
// //         // Upload cover image
// //         final coverImageRef = firebase_storage.FirebaseStorage.instance
// //             .ref()
// //             .child('book_cover/${DateTime.now().millisecondsSinceEpoch}.jpg');
// //         await coverImageRef.putFile(
// //           pickedImageFile!,
// //           firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
// //         );
// //
// //         // Upload PDF file
// //         final pdfRef = firebase_storage.FirebaseStorage.instance
// //             .ref()
// //             .child('book_pdf/${DateTime.now().millisecondsSinceEpoch}.pdf');
// //         await pdfRef.putData(_pdfBytes!);
// //
// //         // Get the download URLs
// //         final coverImageUrl = await coverImageRef.getDownloadURL();
// //         final pdfUrl = await pdfRef.getDownloadURL();
// //         print('Cover Image URL: $coverImageUrl');
// //         print('PDF URL: $pdfUrl');
// //
// //         // Now you can save coverImageUrl, pdfUrl, authorName, bookName, etc., to Firebase database
// //         saveBookData(pdfUrl, coverImageUrl);
// //       } catch (error) {
// //         print('Error uploading files: $error');
// //       }
// //     }
// //
// //     setState(() {
// //       _isLoading = false;
// //     });
// //   }
// //
// //   Future<void> saveBookData(String pdf, String coverImage) async {
// //     try {
// //       await FirebaseFirestore.instance.collection('books').add({
// //         'authorName': authorName.text,
// //         'bookName': bookName.text,
// //         'pdfUrl': pdf,
// //         'coverImage': coverImage
// //       }).then((value) {
// //         print('Pushed');
// //       });
// //       setState(() {
// //         loaded = true;
// //       });
// //       Navigator.pop(context);
// //     } catch (e) {
// //       // Print the error message to debug
// //       print('Error saving book data: $e');
// //
// //       // Show a dialog or toast to inform the user about the error
// //       showDialog(
// //         context: context,
// //         builder: (context) {
// //           return AlertDialog(
// //             title: Text('Error'),
// //             content: Text('Failed to save book data. Please try again later.'),
// //             actions: <Widget>[
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                 },
// //                 child: Text('OK'),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //     }
// //   }
// //
// //   void openCamToTakeImg() async {
// //     final pickedImage = await ImagePicker().pickImage(
// //       source: ImageSource.gallery,
// //       imageQuality: 50,
// //     );
// //     if (pickedImage == null) {
// //       return;
// //     }
// //     setState(() {
// //       pickedImageFile = File(pickedImage.path);
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: kPrimaryColor,
// //       appBar: AppBar(
// //         title: const Text('Upload Book'),
// //       ),
// //       body: Form(
// //         key: _globalKey,
// //         child: Column(
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Center(
// //                   child: _isLoading
// //                       ? const CircularProgressIndicator()
// //                       : Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Icon(
// //                               color: selectedPdf ? Colors.green : Colors.blue,
// //                               selectedPdf ? Icons.done : Icons.picture_as_pdf,
// //                               size: 100,
// //                             ),
// //                             const SizedBox(height: 20),
// //                             ElevatedButton(
// //                               onPressed: selectedPdf ? () {} : _pickPdf,
// //                               child:
// //                                   Text(selectedPdf ? 'Selected' : 'Select pdf'),
// //                             ),
// //                           ],
// //                         ),
// //                 ),
// //                 const SizedBox(
// //                   width: 30,
// //                 ),
// //                 if (pickedImageFile != null)
// //                   Image.file(
// //                     pickedImageFile!,
// //                     width: 100,
// //                     height: 100,
// //                     fit: BoxFit.cover,
// //                   )
// //                 else
// //                   Column(
// //                     children: [
// //                       const Icon(
// //                         color: Colors.blue,
// //                         Icons.image,
// //                         size: 100,
// //                       ),
// //                       const SizedBox(height: 20),
// //                       ElevatedButton(
// //                         onPressed: openCamToTakeImg,
// //                         child: const Text('Select Cover'),
// //                       ),
// //                     ],
// //                   )
// //               ],
// //             ),
// //             const SizedBox(height: 12),
// //             SizedBox(
// //               width: MediaQuery.of(context).size.width / 2,
// //               child: TextFormField(
// //                 controller: authorName,
// //                 validator: (value) {
// //                   if (value == null ||
// //                       value.trim().isEmpty ||
// //                       value.trim().length < 4) {
// //                     return 'Please Enter Valid author Name';
// //                   }
// //                   return null;
// //                 },
// //                 decoration: const InputDecoration(
// //                     border: OutlineInputBorder(), labelText: 'Author name'),
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 12,
// //             ),
// //             SizedBox(
// //               width: MediaQuery.of(context).size.width / 2,
// //               child: TextFormField(
// //                 controller: bookName,
// //                 validator: (value) {
// //                   if (value == null ||
// //                       value.trim().isEmpty ||
// //                       value.trim().length < 4) {
// //                     return 'Please Enter Valid book Name';
// //                   }
// //                   return null;
// //                 },
// //                 decoration: const InputDecoration(
// //                     border: OutlineInputBorder(), labelText: 'Book name'),
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 12,
// //             ),
// //             ElevatedButton(
// //               style: const ButtonStyle(
// //                 elevation: MaterialStatePropertyAll(20),
// //                 fixedSize: MaterialStatePropertyAll(Size(200, 50)),
// //                 backgroundColor: MaterialStatePropertyAll(Colors.blue),
// //               ),
// //               onPressed: () async {
// //                 if (validateAndPublishBook(context)) {
// //                   _uploadFiles();
// //                 } else {
// //                   print('error');
// //                 }
// //               },
// //               child: Text(
// //                 completed ? 'Publish Book' : "Complete all fields",
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 18,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   bool validateAndPublishBook(BuildContext context) {
// //     if (_globalKey.currentState!.validate() &&
// //         bookPdf != null &&
// //         pickedImageFile != null) {
// //       setState(() {
// //         completed = true;
// //       });
// //     }
// //     return _globalKey.currentState!.validate();
// //   }
// // }
// // Future<void> _initializeActivationStates() async {
// //   QuerySnapshot querySnapshot = await _fireStore.collection('users').get();
// //   setState(() {
// //     activationStates = querySnapshot.docs.map((doc) => doc['isActivated'] ?? false).toList();
// //   });
// // }

FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<bool> activationStates = [];

  @override
  void initState() {
    super.initState();
    _initializeActivationStates();
  }

  Future<void> _initializeActivationStates() async {
    QuerySnapshot querySnapshot = await _fireStore.collection('users').get();
    setState(() {
      activationStates = querySnapshot.docs
          .map<bool>((doc) => doc['isActivated'] ?? false)
          .toList();
    });
  }

  // Future<void> _initializeActivationStates() async {
  //   QuerySnapshot querySnapshot = await _fireStore.collection('users').get();
  //   setState(() {
  //     activationStates = querySnapshot.docs.map((doc) => doc['isActivated'] ?? false).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'All Users',
            style: TextStyle(
                color: Color(0xfffbf4ea),
                fontWeight: FontWeight.bold,
                fontSize: 32),
          ),
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, addNewBook);
                },
                icon: const Icon(
                  Icons.add,
                  size: 32,
                  color: Color(0xfffbf4ea),
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminBooks(),
                      ));
                },
                icon: const Icon(
                  Icons.menu_book,
                  size: 32,
                  color: Color(0xfffbf4ea),
                )),
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, loginScreen);
                },
                icon: const Icon(
                  Icons.logout,
                  size: 32,
                  color: Color(0xfffbf4ea),
                )),
            const SizedBox(
              width: 12,
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: const Color(0xfffbf4ea),
        //     onPressed: () {
        //       Navigator.pushNamed(context, addNewBook);
        //     },
        //     child: const Icon(
        //       Icons.add,
        //       size: 30,
        //       color: kPrimaryColor,
        //     )),
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   // actions: [
        //   //   IconButton(
        //   //     onPressed: () async {
        //   //       try {
        //   //         await FirebaseAuth.instance.signOut();
        //   //         Navigator.pushReplacementNamed(context, loginScreen);
        //   //       } catch (error) {
        //   //         ScaffoldMessenger.of(context).clearSnackBars();
        //   //         ScaffoldMessenger.of(context).showSnackBar(
        //   //           SnackBar(content: Text('Authentication Failed')),
        //   //         );
        //   //       }
        //   //     },
        //   //     icon: const Icon(
        //   //       Icons.logout,
        //   //       color: Colors.red,
        //   //     ),
        //   //   )
        //   // ],
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // const Text(
              //   'All Users',
              //   style: TextStyle(
              //       color: Color(0xfffbf4ea),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 32),
              // ),
              const SizedBox(height: 12),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text("No Users Found"),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Something Went Wrong"),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;

                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xfffbf4ea),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 230,
                                  child: ListTile(
                                    title: Text(
                                      data['userName'],
                                      style: const TextStyle(
                                          color: kPrimaryColor, fontSize: 24),
                                    ),
                                    subtitle: Text(data['eMail']),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return activationStates[index]
                                              ? Colors.green
                                              : Colors.blue;
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      _activateAccount(document.id, index);
                                    },
                                    child: Text(
                                      activationStates[index]
                                          ? 'Activated'
                                          : 'Activate',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, addNewBook);
              //     },
              //     child: const Text("Add"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _activateAccount(String userId, int index) async {
    try {
      await _fireStore
          .collection('users')
          .doc(userId)
          .update({'isActivated': true});
      setState(() {
        activationStates[index] = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
