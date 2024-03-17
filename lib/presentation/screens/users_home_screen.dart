import 'package:bookly/Features/home/presentation/views/book_details.dart';
import 'package:bookly/Features/search/presentation/views/search_view.dart';
import 'package:bookly/presentation/screens/pdf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../../Features/home/presentation/views/widgets/custom_book_item.dart';
import '../../constants.dart';
import '../../core/utils/strings.dart';
import '../../core/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool gridView = true;
  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure, doy you want to logout?'),
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
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, loginScreen);
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
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "MAKTABTY",
            style: Styles.textStyle14.copyWith(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w800,
                letterSpacing: 4,
                fontSize: 22,
                color: const Color(0xfffbf4ea)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    gridView = !gridView;
                    print(gridView);
                  });
                },
                icon: Icon(gridView ? Icons.list : Icons.grid_view_rounded)),
            IconButton(
              color: Colors.white,
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchView(),
                    ));
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
            IconButton(
              color: Colors.white,
              onPressed: () async {
                _showAlertDialog(context);
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('books').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator(); // Display loading indicator
              }
              // Widget buildData(){
              //   return
              //
              //     GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),children: snapshot.data!.docs.map((DocumentSnapshot document){
              //     Map<String, dynamic> data =
              //     document.data() as Map<String, dynamic>;
              //     return
              //       Padding(padding: EdgeInsets.all(8),child: Column(children: [
              //       SizedBox(height: 200,child: CustomBookImage(imageUrl: data['bookCover']),),
              //       Text(
              //         "${data['bookName']}",
              //         maxLines: 2,
              //         overflow: TextOverflow.ellipsis,
              //         style: Styles.textStyle30.copyWith(
              //           fontWeight: FontWeight.bold,
              //         ),
              //         // textAlign: TextAlign.center,
              //       ),
              //       const SizedBox(
              //         height: 12,
              //       ),
              //       Opacity(
              //         opacity: .7,
              //         child: Text(
              //           data['bookDescription'] ?? '',
              //           style: Styles.textStyle20.copyWith(
              //               fontSize: 12,
              //               overflow: TextOverflow.ellipsis
              //             // fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 12,
              //       ),
              //       Opacity(
              //           opacity: .7,
              //           child: Row(
              //             children: [
              //               Text('Author : '),
              //               Text(
              //                 data['authorName'],
              //                 style:
              //                 Styles.textStyle18.copyWith(
              //                   fontStyle: FontStyle.italic,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           )),
              //
              //     ],),);
              //   }).toList(),);
              // }
              return gridView
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.7,
                                //  childAspectRatio: 2.4 / 4,
                                crossAxisCount: 2),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookDetailsView(
                                          authorName: data['authorName'],
                                          bookName: data['bookName'],
                                          bookDescription:
                                              data['bookDescription'],
                                          aboutAuthor: '0',
                                          coverImage: data['bookCover'],
                                          coverPdf: data['bookPdf'])
                                      // PdfView(bookUrl: data['bookPdf']),
                                      ));
                            },
                            child: CustomBookImage(imageUrl: data['bookCover']),
                            // Container(
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(16),
                            //       color: const Color(0xfffbf4ea)),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     // mainAxisSize: MainAxisSize.min,
                            //
                            //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       SizedBox(
                            //         height: 220,
                            //         width: 500,
                            //         child:
                            //         CustomBookImage(
                            //             imageUrl: data['bookCover']),
                            //       ),
                            //       // Align(
                            //       //   alignment: AlignmentDirectional.center,
                            //       //   child: Padding(
                            //       //     padding: const EdgeInsets.only(
                            //       //         left: 4.0, right: 4),
                            //       //     child: Text(
                            //       //       "${data['bookName']}",
                            //       //       maxLines: 2,
                            //       //       overflow: TextOverflow.ellipsis,
                            //       //       style: Styles.textStyle30.copyWith(
                            //       //           fontWeight: FontWeight.w200,
                            //       //           color: kPrimaryColor,
                            //       //           fontSize: 22),
                            //       //       // textAlign: TextAlign.center,
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //       // Padding(
                            //       //   padding: const EdgeInsets.only(
                            //       //       left: 4.0, right: 4),
                            //       //   child: Opacity(
                            //       //       opacity: .7,
                            //       //       child: Text(
                            //       //         data['authorName'],
                            //       //         style: Styles.textStyle14.copyWith(
                            //       //             fontStyle: FontStyle.italic,
                            //       //             fontWeight: FontWeight.w500,
                            //       //             color: kPrimaryColor),
                            //       //       )),
                            //       // ),
                            //       // Padding(
                            //       //   padding: const EdgeInsets.only(
                            //       //       left: 4.0, right: 4),
                            //       //   child: Opacity(
                            //       //     opacity: .7,
                            //       //     child: Text(
                            //       //       // maxLines: 2,
                            //       //       data['bookDescription'] ?? '',
                            //       //       maxLines: 2,
                            //       //       style: Styles.textStyle20.copyWith(
                            //       //           fontSize: 12,
                            //       //           overflow: TextOverflow.ellipsis,
                            //       //           color: kPrimaryColor
                            //       //           // fontWeight: FontWeight.bold,
                            //       //           ),
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //       // Divider(
                            //       //   height: 0.2,
                            //       //   color: Color(0xfffbf4ea),
                            //       //   thickness: 0.5,
                            //       //   endIndent: 20,
                            //       //   indent: 20,
                            //       // ),
                            //     ],
                            //   ),
                            // ),
                          );
                        }).toList(),
                      ),
                    )
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
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
                                      CustomBookImage(
                                          imageUrl: data['bookCover']),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              child: Text(
                                                "${data['bookName']}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    Styles.textStyle30.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                // textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Opacity(
                                                opacity: .7,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      data['authorName'],
                                                      style: Styles.textStyle18
                                                          .copyWith(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Opacity(
                                              opacity: .7,
                                              child: Text(
                                                data['bookDescription'] ?? '',
                                                maxLines: 5,
                                                style: Styles.textStyle20.copyWith(
                                                    fontSize: 12,
                                                    overflow:
                                                        TextOverflow.ellipsis
                                                    // fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              // mainAxisAlignment:
                                              // MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PdfView(
                                                                  bookUrl: data[
                                                                      'bookPdf']),
                                                        ));
                                                  },
                                                  child: Container(
                                                    width: 80,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        // color:
                                                        //     Color(0xfffbf4ea),
                                                        //
                                                        // color: Colors
                                                        //     .deepOrangeAccent.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: const Center(
                                                      child: Icon(
                                                        size: 32,
                                                        Icons.menu_book_sharp,
                                                        color: Colors.white,
                                                        //  color: kPrimaryColor,
                                                        // "Read book",
                                                        // style: Styles
                                                        //     .textStyle20
                                                        //     .copyWith(
                                                        //         fontWeight:
                                                        //             FontWeight
                                                        //                 .w400,
                                                        //         color:
                                                        //             kPrimaryColor),
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
                                const SizedBox(
                                  height: 12,
                                ),
                                const Divider(
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
                      ),
                    );

              //   ListView(
              //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
              //     Map<String, dynamic> data =
              //         document.data() as Map<String, dynamic>;
              //     return Padding(
              //       padding: const EdgeInsets.all(12),
              //       child: Column(
              //         children: [
              //           SizedBox(
              //             height: 200,
              //             child: Row(
              //               children: [
              //                 CustomBookImage(imageUrl: data['bookCover']),
              //                 const SizedBox(
              //                   width: 16,
              //                 ),
              //                 Expanded(
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       SizedBox(
              //                         width: MediaQuery.of(context).size.width *
              //                             .5,
              //                         child:
              //                         Text(
              //                           "${data['bookName']}",
              //                           maxLines: 2,
              //                           overflow: TextOverflow.ellipsis,
              //                           style: Styles.textStyle30.copyWith(
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                           // textAlign: TextAlign.center,
              //                         ),
              //                       ),
              //                       const SizedBox(
              //                         height: 12,
              //                       ),
              //                       Opacity(
              //                         opacity: .7,
              //                         child: Text(
              //                           data['bookDescription'] ?? '',
              //                           style: Styles.textStyle20.copyWith(
              //                               fontSize: 12,
              //                               overflow: TextOverflow.ellipsis
              //                               // fontWeight: FontWeight.bold,
              //                               ),
              //                         ),
              //                       ),
              //                       const SizedBox(
              //                         height: 12,
              //                       ),
              //                       Opacity(
              //                           opacity: .7,
              //                           child: Row(
              //                             children: [
              //                               Text('Author : '),
              //                               Text(
              //                                 data['authorName'],
              //                                 style:
              //                                     Styles.textStyle18.copyWith(
              //                                   fontStyle: FontStyle.italic,
              //                                   fontWeight: FontWeight.w500,
              //                                 ),
              //                               ),
              //                             ],
              //                           )),
              //                       Spacer(),
              //                       Row(
              //                         mainAxisAlignment: MainAxisAlignment.end,
              //                         // mainAxisAlignment:
              //                         // MainAxisAlignment.spaceAround,
              //                         children: [
              //                           InkWell(
              //                             onTap: () {
              //                               Navigator.push(
              //                                   context,
              //                                   MaterialPageRoute(
              //                                     builder: (context) => PdfView(
              //                                         bookUrl: data['bookPdf']),
              //                                   ));
              //                             },
              //                             child: Container(
              //                               width: 117,
              //                               height: 35,
              //                               decoration: BoxDecoration(
              //                                   color: Color(0xfffbf4ea),
              //                                   borderRadius:
              //                                       BorderRadius.circular(8)),
              //                               child: Center(
              //                                 child: Text(
              //                                   "Read book ",
              //                                   style: Styles.textStyle20
              //                                       .copyWith(
              //                                           fontWeight:
              //                                               FontWeight.bold,
              //                                           color: kPrimaryColor),
              //                                 ),
              //                               ),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         height: 12,
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: 12,
              //           ),
              //           Divider(
              //             endIndent: 30,
              //             indent: 30,
              //             thickness: 1,
              //             height: 1,
              //             color: Colors.white,
              //           )
              //         ],
              //       ),
              //     );
              //   }).toList(),
              // );
            },
          ),
        ));
  }
}
